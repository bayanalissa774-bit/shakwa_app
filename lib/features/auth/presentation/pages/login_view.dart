// lib/features/auth/presentation/pages/login_view.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitLogin() {
    if (_formKey.currentState!.validate()) {
      // الانتقال إلى الشاشة الرئيسية واستبدال شاشة تسجيل الدخول بها
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double scale = screenWidth / 430.0;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Form(
              key: _formKey,
              child: Stack(
                children: [
                  // 1. الشعار أعلى الشاشة
                  Positioned(
                    top: 44 * scale,
                    left: (screenWidth - (269 * scale)) / 2,
                    width: 269 * scale,
                    height: 76 * scale,
                    child: const Image(
                      image: AssetImage('assets/images/logo.png'),
                      fit: BoxFit.contain,
                    ),
                  ),

                  // 2. الحاوية الرئيسية
                  Positioned(
                    top: 147 * scale,
                    left: 35 * scale,
                    width: 360 * scale,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'اهلا بك',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.tajawal(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF000000),
                          ),
                        ),
                        SizedBox(height: 6 * scale),

                        Text(
                          'سجل بياناتك للوصول الى حسابك',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.tajawal(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF736868),
                          ),
                        ),
                        SizedBox(height: 28 * scale),

                        // --- حقل الاسم ---
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'الاسم',
                            style: GoogleFonts.tajawal(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF000000),
                            ),
                          ),
                        ),
                        SizedBox(height: 6 * scale),
                        TextFormField(
                          controller: _nameController,
                          textAlign: TextAlign.right,
                          style: GoogleFonts.tajawal(fontSize: 14),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return ''; // إرجاع نص فارغ لإظهار الإطار الأحمر فقط
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'ادخل الاسم',
                            hintStyle: GoogleFonts.tajawal(
                              fontSize: 12,
                              color: const Color(0xFFA1A1A1),
                            ),
                            filled: true,
                            fillColor: const Color(0xFFFFFFFF),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 10 * scale,
                              horizontal: 9 * scale,
                            ),
                            // إخفاء مساحة نص الخطأ ليبقى التصميم متناسقاً
                            errorStyle: const TextStyle(height: 0, fontSize: 0),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Color(0xFF01322E),
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Color(0xFF0C655E),
                                width: 1.5,
                              ),
                            ),
                            // الإطار الأحمر عند وجود خطأ في الاسم
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.red,
                                width: 1,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.red,
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 16 * scale),

                        // --- حقل كلمة المرور ---
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                // إجراء نسيت كلمة السر
                              },
                              child: Text(
                                'نسيت كلمة السر',
                                style: GoogleFonts.tajawal(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF1B72C0),
                                ),
                              ),
                            ),
                            Text(
                              'كلمة المرور',
                              style: GoogleFonts.tajawal(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF000000),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6 * scale),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          textAlign: TextAlign.right,
                          style: GoogleFonts.tajawal(fontSize: 14),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return ''; // إرجاع نص فارغ لإظهار الحد الأحمر فقط
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'ادخل كلمة المرور',
                            hintStyle: GoogleFonts.tajawal(
                              fontSize: 12,
                              color: const Color(0xFFA1A1A1),
                            ),
                            filled: true,
                            fillColor: const Color(0xFFFFFFFF),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 10 * scale,
                              horizontal: 9 * scale,
                            ),
                            // إخفاء النص الأحمر السفلي للخطأ
                            errorStyle: const TextStyle(height: 0, fontSize: 0),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Color(0xFF01322E),
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Color(0xFF0C655E),
                                width: 1.5,
                              ),
                            ),
                            // الإطار الأحمر عند الخطأ في كلمة المرور (مطابق تماماً للصورة)
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.red,
                                width: 1,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.red,
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 30 * scale),

                        // --- زر تسجيل الدخول ---
                        SizedBox(
                          width: 360 * scale,
                          height: 40 * scale,
                          child: ElevatedButton(
                            onPressed: _submitLogin,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0C655E),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              'تسجيل الدخول',
                              style: GoogleFonts.tajawal(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 20 * scale),

                        // --- نص إنشاء حساب جديد ---
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/signup');
                          },
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: GoogleFonts.tajawal(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF736868),
                              ),
                              children: [
                                const TextSpan(text: 'ليس لديك حساب؟ '),
                                TextSpan(
                                  text: 'إنشاء حساب جديد',
                                  style: GoogleFonts.tajawal(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF0C655E),
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
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
