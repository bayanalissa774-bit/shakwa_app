// lib/features/auth/presentation/pages/register_view.dart

import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // وحدات التحكم بالحقول النصية
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nationalIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _idCardController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _nationalIdController.dispose();
    _passwordController.dispose();
    _idCardController.dispose();
    super.dispose();
  }

  // ودجت قابلة لإعادة الاستخدام لإنشاء حقول الإدخال والعناوين بسهولة
  Widget _buildInputField({
    required String label,
    required String hintText,
    required TextEditingController controller,
    bool isPassword = false,
    Widget? prefixIcon,
    bool readOnly = false,
    VoidCallback? onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Cairo',
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: isPassword,
          readOnly: readOnly,
          onTap: onTap,
          textAlign: TextAlign.right,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return '';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              fontFamily: 'Cairo',
              color: Colors.grey,
              fontSize: 13,
            ),
            prefixIcon: prefixIcon, // لإضافة أيقونة الرفع على اليسار
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFF4A6B6C)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFF0E6655), width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color(0xFFFF5252),
                width: 1.5,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFFFF5252), width: 2),
            ),
            errorStyle: const TextStyle(height: 0),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),

                // 1. الشعار والنص
                Center(
                  child: Column(
                    children: [
                      Image.asset('assets/images/logo.png', height: 60),
                      const SizedBox(height: 6),
                      const Text(
                        'شكوى',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // 2. العنوان الرئيسي "ابدأ الان"
                const Text(
                  'ابدأ الان',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 25),

                // 3. حقول الإدخال المتعددة
                _buildInputField(
                  label: 'الاسم',
                  hintText: 'ادخل الاسم',
                  controller: _nameController,
                ),
                _buildInputField(
                  label: 'الايميل',
                  hintText: 'ادخل الايميل',
                  controller: _emailController,
                ),
                _buildInputField(
                  label: 'الرقم الوطني',
                  hintText: 'ادخل الرقم الوطني',
                  controller: _nationalIdController,
                ),
                _buildInputField(
                  label: 'كلمة المرور',
                  hintText: 'ادخل كلمة المرور',
                  controller: _passwordController,
                  isPassword: true,
                ),

                // 4. حقل "ادخل صورة عن الهوية" مع أيقونة الرفع
                _buildInputField(
                  label: 'ادخل صورة عن الهوية',
                  hintText: 'ارفق الصورة',
                  controller: _idCardController,
                  readOnly:
                      true, // لمنع الكتابة اليدوية وفتح اختيار الملف عند الضغط
                  onTap: () {
                    // فتح معرض الصور لاحقاً عند الربط البرمجي
                  },
                  prefixIcon: const Icon(
                    Icons
                        .file_download_outlined, // أيقونة الرفع المطابقة للصورة
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 15),

                // 5. زر "إنشاء حساب"
                SizedBox(
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      _formKey.currentState!.validate();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0E6655),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'إنشاء حساب',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // 6. النص السفلي "هل لديك حساب؟ تسجيل الدخول"
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // العودة لشاشة تسجيل الدخول
                        Navigator.pop(context);
                      },
                      child: const Text(
                        ' تسجيل الدخول',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 14,
                          color: Colors.grey,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    const Text(
                      'هل لديك حساب؟',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
