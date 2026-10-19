// ignore_for_file: unused_element, use_build_context_synchronously, prefer_final_fields, unused_field

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/add_complaint/sections/complaint_dropdowns_section.dart';
import '../widgets/add_complaint/inputs/complaint_description_widget.dart';
import '../widgets/add_complaint/sections/complaint_attachments_widget.dart';
import '../widgets/add_complaint/components/add_complaint_app_bar.dart';
import '../widgets/add_complaint/inputs/complaint_text_field.dart';
import '../widgets/add_complaint/sections/complaint_priority_section.dart';
import '../widgets/add_complaint/components/submit_complaint_button.dart';

import '../cubit/complaints_cubit.dart';
import '../cubit/complaints_state.dart';

class AddComplaintPage extends StatelessWidget {
  const AddComplaintPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AddComplaintView();
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

  String _selectedPriority = 'منخفضة';
  bool _isDescriptionExpanded = false;

  int? _selectedCategoryId;
  int? _selectedEntityId;
  bool _isSubmitting = false;

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

    final prefs = await SharedPreferences.getInstance();
    final int citizenId = prefs.getInt('citizen_id') ?? 1;

    _isSubmitting = true;
    await context.read<ComplaintsCubit>().createComplaint(
      title: title,
      description: description,
      categoryId: _selectedCategoryId ?? 1,
      entityId: _selectedEntityId,
      citizenId: citizenId,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double scale = MediaQuery.of(context).size.width / 430.0;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocListener<ComplaintsCubit, ComplaintsState>(
        listener: (context, state) {
          if (!_isSubmitting) return;

          if (state is ComplaintsLoaded) {
            _isSubmitting = false;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'تمت إضافة الشكوى بنجاح!',
                  style: GoogleFonts.tajawal(),
                ),
                duration: const Duration(seconds: 2),
              ),
            );
            Navigator.pop(context, true);
          } else if (state is ComplaintsError) {
            _isSubmitting = false;
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

                  ComplaintDropdownsSection(
                    scale: scale,
                    onChanged: (categoryId, entityId) {
                      setState(() {
                        _selectedCategoryId = categoryId;
                        _selectedEntityId = entityId;
                      });
                    },
                  ),
                  SizedBox(height: 16 * scale),

                  ComplaintPrioritySection(
                    selectedPriority: _selectedPriority,
                    scale: scale,
                    onPrioritySelected: (priority) {
                      setState(() {
                        _selectedPriority = priority;
                      });
                    },
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

                  SubmitComplaintButton(
                    scale: scale,
                    onSubmit: () => _submitComplaint(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}