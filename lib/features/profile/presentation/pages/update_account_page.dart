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
  File? _idImage;
  File? _profileImage;

  final TextEditingController _nameController = TextEditingController(
    text: 'احمد علي خالد',
  );
  final TextEditingController _emailController = TextEditingController(
    text: 'AhmadKhald@gmail.com',
  );
  final TextEditingController _nationalIdController = TextEditingController(
    text: '020202020202020202',
  );
  final TextEditingController _passwordController = TextEditingController(
    text: '****************',
  );

  Future<void> _pickIdImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _idImage = File(image.path);
      });
    }
  }

  Future<void> _pickProfileImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _nationalIdController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double scale = MediaQuery.of(context).size.width / 430.0;
    const Color primaryColor = Color(0xFF0C655E);
    const Color goldColor = Color(0xFFD4AF37);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F8FA),
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0,
          automaticallyImplyLeading: false,
          toolbarHeight: 70 * scale,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // الشعار والعنوان في اليسار (حسب التصميم)
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'شكوى',
                        style: GoogleFonts.tajawal(
                          fontSize: 12 * scale,
                          color: goldColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 8 * scale),
                  Icon(
                    Icons.workspace_premium,
                    color: goldColor,
                    size: 28 * scale,
                  ),
                ],
              ),
              // عنوان الشاشة في المنتصف
              Text(
                'تعديل معلومات الحساب',
                style: GoogleFonts.tajawal(
                  fontSize: 17 * scale,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // زر رجوع في اليمين
              InkWell(
                onTap: () => Navigator.pop(context),
                child: Row(
                  children: [
                    Text(
                      'رجوع',
                      style: GoogleFonts.tajawal(
                        fontSize: 15 * scale,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 4 * scale),
                    const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: 20 * scale,
            vertical: 24 * scale,
          ),
          child: Column(
            children: [
              // صورة البروفايل الدائرية بالأعلى
              Center(
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Container(
                      padding: EdgeInsets.all(3 * scale),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 1.5,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 45 * scale,
                        backgroundColor: Colors.grey.shade100,
                        backgroundImage: _profileImage != null
                            ? FileImage(_profileImage!)
                            : null,
                        child: _profileImage == null
                            ? Icon(
                                Icons.person_outline,
                                size: 50 * scale,
                                color: Colors.grey.shade400,
                              )
                            : null,
                      ),
                    ),
                    InkWell(
                      onTap: _pickProfileImage,
                      child: Container(
                        padding: EdgeInsets.all(6 * scale),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 14 * scale,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24 * scale),

              // حقل الاسم
              _buildTextFieldLabel('الاسم', scale),
              SizedBox(height: 6 * scale),
              _buildCustomTextField(_nameController, false, scale),
              SizedBox(height: 16 * scale),

              // حقل الايميل
              _buildTextFieldLabel('الايميل', scale),
              SizedBox(height: 6 * scale),
              _buildCustomTextField(
                _emailController,
                false,
                scale,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16 * scale),

              // حقل الرقم الوطني
              _buildTextFieldLabel('الرقم الوطني', scale),
              SizedBox(height: 6 * scale),
              _buildCustomTextField(
                _nationalIdController,
                false,
                scale,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16 * scale),

              // حقل كلمة المرور
              _buildTextFieldLabel('كلمة المرور', scale),
              SizedBox(height: 6 * scale),
              _buildCustomTextField(_passwordController, true, scale),
              SizedBox(height: 16 * scale),

              // رفع صورة الهوية
              _buildTextFieldLabel('ادخل صورة عن الهوية', scale),
              SizedBox(height: 6 * scale),
              GestureDetector(
                onTap: _pickIdImage,
                child: Container(
                  height: 52 * scale,
                  padding: EdgeInsets.symmetric(horizontal: 16 * scale),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12 * scale),
                    border: Border.all(
                      color: const Color(0xFFE57373),
                      width: 1,
                    ), // إطار أحمر مطابق للصورة
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.file_upload_outlined,
                        color: Colors.grey.shade600,
                        size: 20 * scale,
                      ),
                      SizedBox(width: 12 * scale),
                      Expanded(
                        child: Text(
                          _idImage != null
                              ? 'تم اختيار صورة الهوية'
                              : 'تغيير صورة الهوية',
                          textAlign: TextAlign.right,
                          style: GoogleFonts.tajawal(
                            fontSize: 14 * scale,
                            color: const Color(0xFF2D2D2D),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 32 * scale),

              // زر حفظ
              SizedBox(
                width: double.infinity,
                height: 52 * scale,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12 * scale),
                    ),
                    elevation: 0,
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

  Widget _buildTextFieldLabel(String label, double scale) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        label,
        style: GoogleFonts.tajawal(
          fontSize: 13 * scale,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF333333),
        ),
      ),
    );
  }

  Widget _buildCustomTextField(
    TextEditingController controller,
    bool obscureText,
    double scale, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textAlign: TextAlign.right,
      style: GoogleFonts.tajawal(
        fontSize: 14 * scale,
        color: const Color(0xFF1E1E1E),
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16 * scale,
          vertical: 14 * scale,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12 * scale),
          borderSide: const BorderSide(
            color: Color(0xFFE57373),
            width: 1,
          ), // إطار أحمر مطابق للفيجما
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12 * scale),
          borderSide: const BorderSide(color: Color(0xFF0C655E), width: 1.5),
        ),
      ),
    );
  }
}
