import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _nationalIdController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // --- دالة معالجة إنشاء الحساب والتوجيه للشاشة الرئيسية ---
  void _submitSignUp() {
    // التنقل المباشر واستبدال الشاشة بـ الشاشة الرئيسية
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    // معامل التناسب بحسب عرض الشاشة المصممة (430px)
    final double screenWidth = MediaQuery.of(context).size.width;
    final double scale = screenWidth / 430.0;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                // 1. Header Frame 100 (الشعار)
                Positioned(
                  top: 45 * scale,
                  left: 4 * scale,
                  width: 430 * scale,
                  height: 76 * scale,
                  child: Center(
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 269 * scale,
                      height: 76 * scale,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                // 2. Main Frame 125 (النموذج الرئيسي)
                Positioned(
                  top: 147 * scale,
                  left: 35 * scale,
                  width: 360 * scale,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // عنوان "ابدأ الان"
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

                      // 1. حقل الاسم
                      _buildInputField(
                        label: 'الاسم',
                        hint: 'ادخل الاسم',
                        controller: _nameController,
                        scale: scale,
                      ),
                      SizedBox(height: 12 * scale),

                      // 2. حقل الايميل
                      _buildInputField(
                        label: 'الايميل',
                        hint: 'ادخل الايميل',
                        controller: _emailController,
                        scale: scale,
                      ),
                      SizedBox(height: 12 * scale),

                      // 3. حقل الرقم الوطني
                      _buildInputField(
                        label: 'الرقم الوطني',
                        hint: 'ادخل الرقم الوطني',
                        controller: _nationalIdController,
                        scale: scale,
                      ),
                      SizedBox(height: 12 * scale),

                      // 4. حقل كلمة المرور
                      _buildInputField(
                        label: 'كلمة المرور',
                        hint: 'ادخل كلمة المرور',
                        controller: _passwordController,
                        isPassword: true,
                        scale: scale,
                      ),
                      SizedBox(height: 12 * scale),

                      // 5. حقل ادخل صورة عن الهوية
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'ادخل صورة عن الهوية',
                          style: GoogleFonts.tajawal(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF000000),
                          ),
                        ),
                      ),
                      SizedBox(height: 6 * scale),
                      InkWell(
                        onTap: () {
                          // إضافة وظيفة رفع الصورة
                        },
                        child: Container(
                          height: 40 * scale,
                          padding: EdgeInsets.symmetric(horizontal: 12 * scale),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color(0xFF01322E),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(
                                Icons.file_upload_outlined,
                                color: Color(0xFF01322E),
                                size: 20,
                              ),
                              Text(
                                'ارفق الصورة',
                                style: GoogleFonts.tajawal(
                                  fontSize: 12,
                                  color: const Color(0xFFA1A1A1),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 30 * scale),

                      // زر إنشاء حساب (تمت إشادة دالة _submitSignUp هنا)
                      SizedBox(
                        width: 360 * scale,
                        height: 40 * scale,
                        child: ElevatedButton(
                          onPressed:
                              _submitSignUp, // <--- استدعاء الدالة عند النقر
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

                      // هل لديك حساب؟ تسجيل الدخول
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

  Widget _buildInputField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required double scale,
    bool isPassword = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: GoogleFonts.tajawal(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF000000),
          ),
        ),
        SizedBox(height: 6 * scale),
        SizedBox(
          height: 40 * scale,
          child: TextField(
            controller: controller,
            obscureText: isPassword,
            textAlign: TextAlign.right,
            style: GoogleFonts.tajawal(fontSize: 14),
            decoration: InputDecoration(
              hintText: hint,
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
            ),
          ),
        ),
      ],
    );
  }
}
