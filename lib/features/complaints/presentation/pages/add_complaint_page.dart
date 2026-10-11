// ignore_for_file: prefer_final_fields, unused_field

import 'package:flutter/material.dart';

import 'dart:io';

import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shakwa_app/features/complaints/presentation/widgets/add_complaint/complaint_dropdown_widget.dart';

import '../widgets/add_complaint/complaint_description_widget.dart';
import '../widgets/add_complaint/complaint_attachments_widget.dart';
import '../widgets/add_complaint/add_complaint_app_bar.dart';
import '../widgets/add_complaint/complaint_text_field.dart';

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

  @override
  Widget build(BuildContext context) {
    final double scale = MediaQuery.of(context).size.width / 430.0;

    return Directionality(
      textDirection: TextDirection.rtl,
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
                  onTap: () => setState(
                    () => _isDescriptionExpanded = !_isDescriptionExpanded,
                  ),
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
                ComplaintDropdownWidget(
                  hint: 'اختر التصنيف المناسب........',
                  value: _selectedCategory,
                  items: _categories,
                  onChanged: (val) => setState(() => _selectedCategory = val),
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
                ComplaintDropdownWidget(
                  hint: 'اختيار الجهة الحكومية',
                  value: _selectedGovernment,
                  items: _governments,
                  onChanged: (val) => setState(() => _selectedGovernment = val),
                  scale: scale,
                ),
                SizedBox(height: 18 * scale),
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
}
