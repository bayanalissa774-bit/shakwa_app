import 'package:flutter/material.dart';
import 'package:shakwa_app/features/profile/presentation/pages/profile_view.dart';

import 'features/splash/presentation/pages/splash_view.dart';
import 'features/splash/presentation/pages/splash_loading_view.dart';
import 'features/auth/presentation/pages/login_view.dart';

import 'features/auth/presentation/pages/signup_view.dart';

import 'package:shakwa_app/features/home/presentation/pages/home_view.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shakwa App',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: GoogleFonts.tajawal().fontFamily,
      ),

      // الشاشة الأولى التي سيبدأ منها التطبيق
      initialRoute: '/',

      // جدول المسارات والتنقلات
      routes: {
        '/': (context) => const SplashView(), // 1. الشاشة الأولى
        '/splash-loading': (context) =>
            const SplashLoadingView(), // 2. شاشة التحميل
        '/login': (context) => const LoginView(), // 3. شاشة تسجيل الدخول

        '/signup': (context) => const SignUpView(),
        '/home': (context) => HomeView(), // 4. شاشة الصفحة الرئيسية
      },
    );
  }
}
