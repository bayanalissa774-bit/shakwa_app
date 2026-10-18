// ignore_for_file: unused_element, use_build_context_synchronously, prefer_final_fields, unused_field

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dart:io';

import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';

// استيراد طبقات المشروع لإنشاء الـ Cubit محلياً
import 'package:shakwa_app/features/complaints/data/datasources/complaints_remote_data_source.dart';
import 'package:shakwa_app/features/complaints/data/repositories/complaints_repository_impl.dart';
import 'package:shakwa_app/features/complaints/domain/usecases/add_complaint_usecase.dart';
import 'package:shakwa_app/features/complaints/domain/usecases/get_complaints_usecase.dart';

import 'package:shakwa_app/features/complaints/presentation/widgets/add_complaint/complaint_dropdown_widget.dart';

import '../widgets/add_complaint/complaint_description_widget.dart';
import '../widgets/add_complaint/complaint_attachments_widget.dart';
import '../widgets/add_complaint/add_complaint_app_bar.dart';
import '../widgets/add_complaint/complaint_text_field.dart';

import '../cubit/complaints_cubit.dart';
import '../cubit/complaints_state.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AddComplaintPage extends StatelessWidget {
  const AddComplaintPage({super.key});

  @override
  Widget build(BuildContext context) {
    // تزويد الـ Cubit محلياً لهذه الصفحة لضمان عدم ظهور خطأ الـ Provider نهائياً
    return BlocProvider(
      create: (context) {
        final dio = Dio();
        final remoteDataSource = ComplaintsRemoteDataSourceImpl(dio);
        final repository = ComplaintsRepositoryImpl(remoteDataSource);

        return ComplaintsCubit(
          getComplaintsUseCase: GetComplaintsUseCase(repository),
          addComplaintUseCase: AddComplaintUseCase(repository),
        );
      },
      child: const AddComplaintView(),
    );
  }
}

class AddComplaintView extends StatefulWidget {
  const AddComplaintView({super.key});

  @override
  State<AddComplaintView> createState() => _AddComplaintViewState();
}

class _AddComplaintViewState extends State<AddComplaintView> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String? _selectedGovernment;
  String _selectedPriority = 'منخفضة';
  bool _isDescriptionExpanded = false;

  // 🟢 أضف هذه المتغيرات ودالة الـ initState هنا تماماً:
  int? _selectedCategoryId;
  List<Map<String, dynamic>> _categoriesList = [];
  bool _isLoadingCategories = true;
  // --- 🟢 أضف هذه المتغيرات الجديدة للجهات الحكومية هنا ---
  int? _selectedEntityId;
  List<Map<String, dynamic>> _entitiesList = [];
  bool _isLoadingEntities = true;
  @override
  void initState() {
    super.initState();
    _fetchCategories(); // جلب التصنيفات
    _fetchTargetEntities(); // 🟢 جلب الجهات الحكومية
  }

  Future<void> _fetchCategories() async {
    try {
      final dio = Dio();
      // 🟢 تم تصحيح الرابط هنا ليوافق الـ API المعتمد في مشروعك
      final response = await dio.get(
        'https://palegoldenrod-rabbit-772161.hostingersite.com/api/v1/category/get.php',
      );

      print('=== CATEGORIES RESPONSE ===: ${response.data}');

      if (response.statusCode == 200 && response.data != null) {
        dynamic rawData = response.data;
        if (rawData is Map && rawData.containsKey('data')) {
          rawData = rawData['data'];
        }

        if (rawData is List) {
          setState(() {
            _categoriesList = rawData.map<Map<String, dynamic>>((item) {
              return {
                // الحقول المتوافقة مع جدول التصنيفات في مشروعك
                'id':
                    item['category_number'] ??
                    item['id'] ??
                    item['category_id'] ??
                    1,
                'name':
                    item['category_name'] ??
                    item['name'] ??
                    item['title'] ??
                    'تصنيف',
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
      // قائمة احتياطية لكي لا تتعطل الشاشة إذا لم يوجد إنترنت
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

  final List<dynamic> _complaintImages = [
    'assets/images/trash_complaint.png',
    'assets/images/drought_complaint.png',
  ];

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _complaintImages.add(File(image.path));
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  // 1. أضف كلمة async هنا لأننا سنقرأ بيانات بشكل غير同步 (Asynchronous) من الذاكرة
  Future<void> _submitComplaint(BuildContext context) async {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();

    if (title.isEmpty || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'الرجاء تعبئة العنوان ووصف الشكوى',
            style: GoogleFonts.tajawal(),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }

    // 🟢 قراءة رقم المواطن من SharedPreferences
    // ==========================================
    final prefs = await SharedPreferences.getInstance();
    // نقرأ الرقم المخزن، وإذا لمשن موجوداً نخزن/نستعمل 1 كقيمة افتراضية مؤقتة
    final int citizenId = prefs.getInt('citizen_id') ?? 1;
    // ==========================================

    // إرسال الشكوى مع الـ citizenId الحقيقي المستخرج من الذاكرة
    context.read<ComplaintsCubit>().createComplaint(
      title: title,
      description: description,
      categoryId: _selectedCategoryId ?? 1,
      entityId: _selectedEntityId, // 🟢 أضف هذا السطر هنا
      citizenId: citizenId,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double scale = MediaQuery.of(context).size.width / 430.0;
    const Color primaryColor = Color(0xFF0C655E);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocListener<ComplaintsCubit, ComplaintsState>(
        listener: (context, state) {
          if (state is ComplaintsLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'تمت إضافة الشكوى بنجاح!',
                  style: GoogleFonts.tajawal(),
                ),
                duration: const Duration(seconds: 2),
              ),
            );
            // 🟢 ضع هذا السطر مكانهما:
            Navigator.pop(context, true);
          } else if (state is ComplaintsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'خطأ: ${state.message}',
                  style: GoogleFonts.tajawal(),
                ),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 3),
              ),
            );
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AddComplaintAppBar(scale: scale),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(18 * scale),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ComplaintTextField(
                    label: 'عنوان الشكوى',
                    hint: 'اكتب عنوان الشكوى........',
                    controller: _titleController,
                    scale: scale,
                  ),
                  SizedBox(height: 16 * scale),
                  Text(
                    'وصف الشكوى',
                    style: GoogleFonts.tajawal(
                      fontSize: 14.5 * scale,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8 * scale),
                  ComplaintDescriptionWidget(
                    controller: _descriptionController,
                    isExpanded: _isDescriptionExpanded,
                    scale: scale,
                  ),
                  SizedBox(height: 16 * scale),
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
                          hint: 'اختر التصنيف المناسب........',
                          value: _selectedCategoryId != null
                              ? _categoriesList.firstWhere(
                                  (cat) => cat['id'] == _selectedCategoryId,
                                  orElse: () => {'name': ''},
                                )['name']
                              : null,
                          items: _categoriesList
                              .map((cat) => cat['name'].toString())
                              .toList(),
                          onChanged: (val) {
                            final selected = _categoriesList.firstWhere(
                              (cat) => cat['name'] == val,
                            );
                            setState(() {
                              _selectedCategoryId = selected['id'];
                            });
                          },
                          scale: scale,
                        ),
                  SizedBox(height: 14 * scale),
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
                          items: _entitiesList
                              .map((ent) => ent['name'].toString())
                              .toList(),
                          onChanged: (val) {
                            final selected = _entitiesList.firstWhere(
                              (ent) => ent['name'] == val,
                            );
                            setState(() {
                              _selectedEntityId = selected['id'];
                            });
                          },
                          scale: scale,
                        ),
                  SizedBox(height: 16 * scale),

                  // ==========================================
                  Text(
                    'درجة الأولوية',
                    style: GoogleFonts.tajawal(
                      fontSize: 14.5 * scale,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8 * scale),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildPriorityButton(
                        'عالية',
                        const Color(0xFFFF5252),
                        scale,
                      ),
                      _buildPriorityButton(
                        'متوسطة',
                        const Color(0xFFFFC107),
                        scale,
                      ),
                      _buildPriorityButton(
                        'منخفضة',
                        const Color(0xFF00C853),
                        scale,
                      ),
                    ],
                  ),
                  SizedBox(height: 18 * scale),
                  // ==========================================

                  Text(
                    'المرفقات',
                    style: GoogleFonts.tajawal(
                      fontSize: 14.5 * scale,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 10 * scale),
                  ComplaintAttachmentsWidget(
                    images: _complaintImages,
                    onAddImageTap: _pickImage,
                    scale: scale,
                  ),
                  SizedBox(height: 25 * scale),
                  BlocBuilder<ComplaintsCubit, ComplaintsState>(
                    builder: (context, state) {
                      final isLoading = state is ComplaintsLoading;
                      return SizedBox(
                        width: double.infinity,
                        height: 48 * scale,
                        child: ElevatedButton(
                          onPressed: isLoading
                              ? null
                              : () => _submitComplaint(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8 * scale),
                            ),
                          ),
                          child: isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  'إرسال الشكوى',
                                  style: GoogleFonts.tajawal(
                                    fontSize: 17 * scale,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 🛠️ دالة مساعدة لتصميم أزرار الأولوية بشكل متناسق مع الفيجما
  // 🛠️ دالة مساعدة لتصميم أزرار الأولوية بشكل متناسق مع الفيجما
  Widget _buildPriorityButton(String title, Color activeColor, double scale) {
    final bool isSelected = _selectedPriority == title;
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4 * scale),
        child: OutlinedButton(
          onPressed: () {
            setState(() {
              _selectedPriority = title;
            });
          },
          style: OutlinedButton.styleFrom(
            side: BorderSide(
              color: isSelected ? activeColor : Colors.grey.shade400,
              width: isSelected ? 2 : 1,
            ),
            backgroundColor: isSelected
                ? activeColor.withOpacity(0.1)
                : Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20 * scale),
            ),
            padding: EdgeInsets.symmetric(vertical: 10 * scale),
          ),
          child: Text(
            title,
            style: GoogleFonts.tajawal(
              fontSize: 13 * scale,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? activeColor : Colors.black12,
            ),
          ),
        ),
      ),
    );
  }
}
