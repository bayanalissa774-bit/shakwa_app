import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shakwa_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:shakwa_app/features/auth/presentation/cubit/auth_state.dart';
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
  final TextEditingController _phoneController = TextEditingController();
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _nationalIdController.dispose();
    _passwordController.dispose();
    _idCardController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _submitRegister() {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthCubit>(context).register(
        citizenName: _nameController.text.trim(),
        phoneNumber: _phoneController.text.trim(),
        password: _passwordController.text.trim(),
        email: _emailController.text.trim(),
        nationalId: _nationalIdController.text.trim(),
        identityImage: _idCardController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.pushReplacementNamed(context, '/home');
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: CircularProgressIndicator(color: Color(0xFF0C655E)),
            ),
          );
        }
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
                      label: 'رقم الهاتف',
                      hintText: 'ادخل رقم الهاتف',
                      controller:
                          _phoneController, // ربطناه بالكونترولر الخاص به
                    ),
                    AuthInputField(
                      label: 'ادخل صورة عن الهوية',
                      hintText: 'ارفق الصورة',
                      controller: _idCardController,
                      readOnly: true,
                      onTap: () async {
                        final ImagePicker picker = ImagePicker();
                        final XFile? image = await picker.pickImage(
                          source: ImageSource.gallery,
                        );

                        if (image != null) {
                          setState(() {
                            _idCardController.text =
                                image.path; // لحفظ مسار الصورة في الحقل
                          });
                        }
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
                        onPressed: _submitRegister,
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
      },
    );
  }
}
