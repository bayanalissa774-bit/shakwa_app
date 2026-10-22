import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shakwa_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:shakwa_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:shakwa_app/features/auth/presentation/widgets/auth_logo.dart';
import 'package:shakwa_app/features/auth/presentation/widgets/auth_text_field.dart';

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
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double scale = screenWidth / 430.0;
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.pushReplacementNamed(context, '/home');
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: Color(0xFF0C655E)),
            ),
          );
        }
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
                      AuthLogo(scale: scale, screenWidth: screenWidth),
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
                            AuthTextField(
                              label: 'الاسم',
                              hint: 'ادخل الاسم',
                              controller: _nameController,
                              scale: scale,
                            ),
                            SizedBox(height: 16 * scale),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {},
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
                            AuthTextField(
                              label: '',
                              hint: 'ادخل كلمة المرور',
                              controller: _passwordController,
                              obscureText: true,
                              scale: scale,
                            ),
                            SizedBox(height: 30 * scale),
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
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                  context,
                                  '/signup',
                                );
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
      },
    );
  }
}
