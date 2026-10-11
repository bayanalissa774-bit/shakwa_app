import 'package:flutter/material.dart';
import 'package:shakwa_app/features/auth/presentation/widgets/auth_input_field.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

                // 2. العنوان الرئيسي
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

                // 3. حقول الإدخال المستقلة
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
                    // فتح معرض الصور لاحقاً
                  },
                  prefixIcon: const Icon(
                    Icons.file_download_outlined,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 15),

                // 4. زر "إنشاء حساب"
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

                // 5. النص السفلي
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
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
