// ignore_for_file: prefer_final_fields, unused_field

import 'package:flutter/material.dart';

import 'dart:io';

import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shakwa_app/features/home/presentation/pages/home_view.dart';

import '../widgets/complaint_dropdown_widget.dart';
import '../widgets/complaint_description_widget.dart';
import '../widgets/complaint_attachments_widget.dart';

class AddComplaintPage extends StatefulWidget {
  const AddComplaintPage({super.key});

  @override
  State<AddComplaintPage> createState() => _AddComplaintPageState();
}

class _AddComplaintPageState extends State<AddComplaintPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String? _selectedCategory;
  String? _selectedGovernment;
  String _selectedPriority = 'منخفضة';
  bool _isDescriptionExpanded = false;

  final List<String> _categories = [
    'خدمات عامة',
    'كهرباء ومياه',
    'طرق ومواصلات',
    'صحة',
  ];
  final List<String> _governments = [
    'وزارة الأشغال',
    'البلدية',
    'وزارة الكهرباء',
    'وزارة الصحة',
  ];
  final List<dynamic> _complaintImages = [
    'assets/images/trash_complaint.png',
    'assets/images/drought_complaint.png',
  ];

  // دالة اختيار الصورة
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _complaintImages.add(File(image.path)); // إضافة الصورة الجديدة للقائمة
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double scale = MediaQuery.of(context).size.width / 430.0;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color(0xFF0C655E),
          elevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16 * scale),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // اليمين: زر رجوع والسهم
                  InkWell(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeView(),
                        ),
                        (route) => false,
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 20 * scale,
                        ),
                        SizedBox(width: 4 * scale),
                        Text(
                          'رجوع',
                          style: GoogleFonts.tajawal(
                            fontSize: 16 * scale,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // الوسط: عنوان الشاشة
                  Text(
                    'تقديم شكوى جديدة',
                    style: GoogleFonts.tajawal(
                      fontSize: 17 * scale,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // اليسار: الشعار والنسر مع كلمة شكوى
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        height: 42 * scale,
                        width: 83 * scale,
                        errorBuilder: (context, error, stackTrace) => Icon(
                          Icons.shield,
                          color: const Color(0xFFD4AF37),
                          size: 37 * scale,
                        ),
                      ),
                      SizedBox(height: 3 * scale),
                      Text(
                        'شكوى',
                        style: GoogleFonts.tajawal(
                          fontSize: 10 * scale,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(18 * scale),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. عنوان الشكوى
                _buildLabel('عنوان الشكوى', scale),
                SizedBox(height: 8 * scale),
                TextField(
                  controller: _titleController,
                  textAlign: TextAlign.right,
                  decoration: _inputDeco('اكتب عنوان الشكوى........', scale),
                ),
                SizedBox(height: 16 * scale),

                // 2. وصف الشكوى (مفصول بـ Widget)
                _buildLabel('وصف الشكوى', scale),
                SizedBox(height: 8 * scale),
                ComplaintDescriptionWidget(
                  controller: _descriptionController,
                  isExpanded: _isDescriptionExpanded,
                  onTap: () => setState(
                    () => _isDescriptionExpanded = !_isDescriptionExpanded,
                  ),
                  scale: scale,
                ),
                SizedBox(height: 16 * scale),

                // 3. تصنيف الشكوى (مفصول بـ Widget بحجم مناسب)
                _buildLabel('تصنيف الشكوى', scale),
                SizedBox(height: 8 * scale),
                ComplaintDropdownWidget(
                  hint: 'اختر التصنيف المناسب........',
                  value: _selectedCategory,
                  items: _categories,
                  onChanged: (val) => setState(() => _selectedCategory = val),
                  scale: scale,
                ),
                SizedBox(height: 14 * scale),

                // 4. الجهة الحكومية
                _buildLabel('الجهات الحكومية', scale),
                SizedBox(height: 8 * scale),
                ComplaintDropdownWidget(
                  hint: 'اختيار الجهة الحكومية',
                  value: _selectedGovernment,
                  items: _governments,
                  onChanged: (val) => setState(() => _selectedGovernment = val),
                  scale: scale,
                ),
                SizedBox(height: 18 * scale),

                // 5. المرفقات (مفصول بـ Widget)
                _buildLabel('المرفقات', scale),
                SizedBox(height: 10 * scale),
                ComplaintAttachmentsWidget(
                  images: _complaintImages,
                  onAddImageTap:
                      _pickImage, // 👈 هنا نمرر الدالة مباشرة ليفتح المعرض
                  scale: scale,
                ),
                SizedBox(height: 25 * scale),

                // 6. زر الإرسال
                SizedBox(
                  width: double.infinity,
                  height: 48 * scale,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0C655E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8 * scale),
                      ),
                    ),
                    child: Text(
                      'إرسال الشكوى',
                      style: GoogleFonts.tajawal(
                        fontSize: 17 * scale,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String title, double scale) {
    return Text(
      title,
      style: GoogleFonts.tajawal(
        fontSize: 14.5 * scale,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  InputDecoration _inputDeco(String hint, double scale) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.tajawal(
        color: Colors.grey.shade400,
        fontSize: 12 * scale,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10 * scale),
      ),
    );
  }
}
