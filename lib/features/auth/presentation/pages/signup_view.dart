import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shakwa_app/features/auth/presentation/widgets/auth_logo.dart';
import 'package:shakwa_app/features/auth/presentation/widgets/auth_input_field.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
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

  void _submitSignUp() {
    Navigator.pushReplacementNamed(context, '/home');
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
            height: MediaQuery.of(context).size.height * 1.15,
            child: Stack(
              children: [
                AuthLogo(scale: scale, screenWidth: screenWidth),
                Positioned(
                  top: 147 * scale,
                  left: 35 * scale,
                  width: 360 * scale,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'ابدأ الان',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.tajawal(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF000000),
                        ),
                      ),
                      SizedBox(height: 18 * scale),
                      AuthInputField(
                        label: 'الاسم',
                        hintText: 'ادخل الاسم',
                        controller: _nameController,
                      ),
                      AuthInputField(
                        label: 'الايميل',
                        hintText: 'ادخل الايميل',
                        controller: _emailController,
                      ),
                      AuthInputField(
                        label: 'الرقم الوطني',
                        hintText: 'ادخل الرقم الوطني',
                        controller: _nationalIdController,
                      ),
                      AuthInputField(
                        label: 'كلمة المرور',
                        hintText: 'ادخل كلمة المرور',
                        controller: _passwordController,
                        isPassword: true,
                      ),
                      AuthInputField(
                        label: 'ادخل صورة عن الهوية',
                        hintText: 'ارفق الصورة',
                        controller: _idCardController,
                        readOnly: true,
                        onTap: () {
                          // إضافة وظيفة رفع الصورة
                        },
                        prefixIcon: const Icon(
                          Icons.file_upload_outlined,
                          color: Color(0xFF01322E),
                          size: 20,
                        ),
                      ),
                      SizedBox(height: 20 * scale),
                      SizedBox(
                        width: 360 * scale,
                        height: 40 * scale,
                        child: ElevatedButton(
                          onPressed: _submitSignUp,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0C655E),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            'إنشاء حساب',
                            style: GoogleFonts.tajawal(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20 * scale),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
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
                              const TextSpan(text: 'هل لديك حساب؟ '),
                              TextSpan(
                                text: 'تسجيل الدخول',
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
    );
  }
}
