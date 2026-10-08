// lib/features/profile/presentation/pages/update_account_page.dart

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

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
              Center(
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    CircleAvatar(
                      radius: 45 * scale,
                      backgroundColor: Colors.grey.shade200,
                      backgroundImage: _profileImage != null
                          ? FileImage(_profileImage!)
                          : null,
                      child: _profileImage == null
                          ? Icon(
                              Icons.person,
                              size: 45 * scale,
                              color: Colors.grey.shade400,
                            )
                          : null,
                    ),
                    InkWell(
                      onTap: () => _pickImage(false),
                      child: Container(
                        padding: EdgeInsets.all(6 * scale),
                        decoration: const BoxDecoration(
                          color: primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20 * scale),

              _field('الاسم الكامل', _nameCtrl, 'أدخل الاسم', scale),
              _field(
                'البريد الإلكتروني',
                _emailCtrl,
                'example@gmail.com',
                scale,
                type: TextInputType.emailAddress,
              ),
              _field(
                'الرقم الوطني',
                _nationalIdCtrl,
                'أدخل الرقم الوطني',
                scale,
                type: TextInputType.number,
              ),
              _field(
                'كلمة المرور',
                _passwordCtrl,
                '••••••••••••',
                scale,
                obscure: true,
              ),

              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'ادخل صورة عن الهوية',
                  style: GoogleFonts.tajawal(
                    fontSize: 13 * scale,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 6 * scale),
              GestureDetector(
                onTap: () => _pickImage(true),
                child: Container(
                  height: 50 * scale,
                  padding: EdgeInsets.symmetric(horizontal: 16 * scale),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12 * scale),
                    border: Border.all(
                      color: (_submitted && _idImage == null)
                          ? Colors.red
                          : Colors.grey.shade300,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.upload_file,
                        color: (_submitted && _idImage == null)
                            ? Colors.red
                            : primary,
                        size: 20,
                      ),
                      SizedBox(width: 12 * scale),
                      Expanded(
                        child: Text(
                          _idImage != null
                              ? 'تم اختيار صورة الهوية بنجاح'
                              : 'تغيير صورة الهوية',
                          textAlign: TextAlign.right,
                          style: GoogleFonts.tajawal(
                            fontSize: 13 * scale,
                            color: _idImage != null
                                ? primary
                                : Colors.grey.shade600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (_submitted && _idImage == null)
                Padding(
                  padding: const EdgeInsets.only(top: 4, right: 8),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'يرجى اختيار صورة الهوية',
                      style: GoogleFonts.tajawal(
                        fontSize: 11,
                        color: Colors.red,
                      ),
                    ),
                  ),
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

  Widget _field(
    String label,
    TextEditingController ctrl,
    String hint,
    double scale, {
    bool obscure = false,
    TextInputType type = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: GoogleFonts.tajawal(
            fontSize: 13 * scale,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 6 * scale),
        TextFormField(
          controller: ctrl,
          obscureText: obscure,
          keyboardType: type,
          textAlign: TextAlign.right,
          style: GoogleFonts.tajawal(fontSize: 14 * scale),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: hint,
            hintStyle: GoogleFonts.tajawal(
              fontSize: 13 * scale,
              color: Colors.grey.shade400,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16 * scale,
              vertical: 14 * scale,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12 * scale),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12 * scale),
              borderSide: const BorderSide(
                color: Color(0xFF0C655E),
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12 * scale),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12 * scale),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),
          ),
          validator: (v) => v == null || v.isEmpty ? 'هذا الحقل مطلوب' : null,
        ),
        SizedBox(height: 14 * scale),
      ],
    );
  }
}
