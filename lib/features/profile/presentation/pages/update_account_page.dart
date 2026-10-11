import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shakwa_app/features/profile/presentation/widgets/update_account/custom_text_field_widget.dart';
import 'package:shakwa_app/features/profile/presentation/widgets/update_account/update_profile_header.dart';
import 'package:shakwa_app/features/profile/presentation/widgets/update_account/update_id_card_picker.dart';

class UpdateAccountPage extends StatefulWidget {
  const UpdateAccountPage({super.key});

  @override
  State<UpdateAccountPage> createState() => _UpdateAccountPageState();
}

class _UpdateAccountPageState extends State<UpdateAccountPage> {
  final _formKey = GlobalKey<FormState>();
  File? _idImage;
  File? _profileImage;
  bool _submitted = false;

  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _nationalIdCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _nationalIdCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickImage(bool isId) async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        if (isId) {
          _idImage = File(picked.path);
        } else {
          _profileImage = File(picked.path);
        }
      });
    }
  }

  void _save() {
    setState(() => _submitted = true);
    if (_formKey.currentState!.validate() && _idImage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'تم تعديل المعلومات بنجاح',
            style: GoogleFonts.tajawal(fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color(0xFF0C655E),
          behavior: SnackBarBehavior.floating,
        ),
      );
      Future.delayed(
        const Duration(milliseconds: 1200),
        () => Navigator.pop(context),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final scale = MediaQuery.of(context).size.width / 430.0;
    const primary = Color(0xFF0C655E);
    const gold = Color(0xFFD4AF37);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        backgroundColor: primary,
        automaticallyImplyLeading: false,
        toolbarHeight: 65 * scale,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  'شكوى',
                  style: GoogleFonts.tajawal(
                    fontSize: 12 * scale,
                    color: gold,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 6 * scale),
                Icon(Icons.workspace_premium, color: gold, size: 26 * scale),
              ],
            ),
            Text(
              'تعديل معلومات الحساب',
              style: GoogleFonts.tajawal(
                fontSize: 16 * scale,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Row(
                children: [
                  Text(
                    'رجوع',
                    style: GoogleFonts.tajawal(
                      fontSize: 14 * scale,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 4 * scale),
                  const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 18,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20 * scale),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              UpdateProfileHeader(
                profileImage: _profileImage,
                onPickImage: () => _pickImage(false),
                scale: scale,
                primaryColor: primary,
              ),
              SizedBox(height: 20 * scale),

              CustomTextFieldWidget(
                label: 'الاسم الكامل',
                controller: _nameCtrl,
                hint: 'أدخل الاسم',
                scale: scale,
              ),
              CustomTextFieldWidget(
                label: 'البريد الإلكتروني',
                controller: _emailCtrl,
                hint: 'example@gmail.com',
                scale: scale,
                type: TextInputType.emailAddress,
              ),
              CustomTextFieldWidget(
                label: 'الرقم الوطني',
                controller: _nationalIdCtrl,
                hint: 'أدخل الرقم الوطني',
                scale: scale,
                type: TextInputType.number,
              ),
              CustomTextFieldWidget(
                label: 'كلمة المرور',
                controller: _passwordCtrl,
                hint: '••••••••••••',
                scale: scale,
                obscure: true,
              ),

              UpdateIdCardPicker(
                idImage: _idImage,
                submitted: _submitted,
                onPickIdImage: () => _pickImage(true),
                scale: scale,
                primaryColor: primary,
              ),

              SizedBox(height: 30 * scale),
              SizedBox(
                width: double.infinity,
                height: 50 * scale,
                child: ElevatedButton(
                  onPressed: _save,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12 * scale),
                    ),
                  ),
                  child: Text(
                    'حفظ',
                    style: GoogleFonts.tajawal(
                      fontSize: 16 * scale,
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
    );
  }
}
