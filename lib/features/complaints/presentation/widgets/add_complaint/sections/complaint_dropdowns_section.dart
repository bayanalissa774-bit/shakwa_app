// ignore_for_file: avoid_print, use_super_parameters

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'complaint_dropdown_widget.dart'; // تأكد من مسار الـ widget لديك

class ComplaintDropdownsSection extends StatefulWidget {
  final double scale;
  final Function(int? categoryId, int? entityId) onChanged;

  const ComplaintDropdownsSection({
    Key? key,
    required this.scale,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<ComplaintDropdownsSection> createState() =>
      _ComplaintDropdownsSectionState();
}

class _ComplaintDropdownsSectionState extends State<ComplaintDropdownsSection> {
  // متغيرات التصنيفات
  int? _selectedCategoryId;
  List<Map<String, dynamic>> _categoriesList = [];
  bool _isLoadingCategories = true;

  // متغيرات الجهات الحكومية
  int? _selectedEntityId;
  List<Map<String, dynamic>> _entitiesList = [];
  bool _isLoadingEntities = true;

  @override
  void initState() {
    super.initState();
    _fetchCategories();
    _fetchTargetEntities();
  }

  Future<void> _fetchCategories() async {
    try {
      final dio = Dio();
      final response = await dio.get(
        'https://palegoldenrod-rabbit-772161.hostingersite.com/api/v1/category/get.php',
      );

      if (response.statusCode == 200 && response.data != null) {
        dynamic rawData = response.data;
        if (rawData is Map && rawData.containsKey('data')) {
          rawData = rawData['data'];
        }

        if (rawData is List) {
          setState(() {
            _categoriesList = rawData.map<Map<String, dynamic>>((item) {
              return {
                'id': item['category_number'] ?? item['id'] ?? item['category_id'] ?? 1,
                'name': item['category_name'] ?? item['name'] ?? item['title'] ?? 'تصنيف',
              };
            }).toList();
          });
        }
      }
    } catch (e) {
      print('=== CATEGORIES ERROR ===: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingCategories = false;
        });
      }
    }
  }

  Future<void> _fetchTargetEntities() async {
    try {
      final dio = Dio();
      final response = await dio.get(
        'https://palegoldenrod-rabbit-772161.hostingersite.com/api/v1/target_entity/get.php',
      );

      if (response.statusCode == 200 && response.data != null) {
        dynamic rawData = response.data;
        if (rawData is Map && rawData.containsKey('data')) {
          rawData = rawData['data'];
        }

        if (rawData is List) {
          setState(() {
            _entitiesList = rawData.map<Map<String, dynamic>>((item) {
              return {
                'id': item['entity_number'] ?? 1,
                'name': item['name_of_the_entity'] ?? 'جهة حكومية',
              };
            }).toList();
          });
        }
      }
    } catch (e) {
      print('خطأ في جلب الجهات الحكومية: $e');
      if (_entitiesList.isEmpty) {
        setState(() {
          _entitiesList = [
            {'id': 1, 'name': 'بلدية الرياض'},
            {'id': 2, 'name': 'وزارة الكهرباء'},
          ];
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingEntities = false;
        });
      }
    }
  }

  void _notifyParent() {
    widget.onChanged(_selectedCategoryId, _selectedEntityId);
  }

  @override
  Widget build(BuildContext context) {
    final scale = widget.scale;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- قسم التصنيفات ---
        Text(
          'تصنيف الشكوى',
          style: GoogleFonts.tajawal(
            fontSize: 14.5 * scale,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8 * scale),
        _isLoadingCategories
            ? const Center(child: CircularProgressIndicator())
            : ComplaintDropdownWidget(
                hint: '.......اختر التصنيف المناسب',
                value: _selectedCategoryId != null
                    ? _categoriesList.firstWhere(
                        (cat) => cat['id'] == _selectedCategoryId,
                        orElse: () => {'name': ''},
                      )['name']
                    : null,
                items: _categoriesList.map((cat) => cat['name'].toString()).toList(),
                onChanged: (val) {
                  final selected = _categoriesList.firstWhere(
                    (cat) => cat['name'] == val,
                  );
                  setState(() {
                    _selectedCategoryId = selected['id'];
                  });
                  _notifyParent();
                },
                scale: scale,
              ),

        SizedBox(height: 14 * scale),

        // --- قسم الجهات الحكومية ---
        Text(
          'الجهات الحكومية',
          style: GoogleFonts.tajawal(
            fontSize: 14.5 * scale,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8 * scale),
        _isLoadingEntities
            ? const Center(child: CircularProgressIndicator())
            : ComplaintDropdownWidget(
                hint: 'اختيار الجهة الحكومية',
                value: _selectedEntityId != null
                    ? _entitiesList.firstWhere(
                        (ent) => ent['id'] == _selectedEntityId,
                        orElse: () => {'name': ''},
                      )['name']
                    : null,
                items: _entitiesList.map((ent) => ent['name'].toString()).toList(),
                onChanged: (val) {
                  final selected = _entitiesList.firstWhere(
                    (ent) => ent['name'] == val,
                  );
                  setState(() {
                    _selectedEntityId = selected['id'];
                  });
                  _notifyParent();
                },
                scale: scale,
              ),
      ],
    );
  }
}