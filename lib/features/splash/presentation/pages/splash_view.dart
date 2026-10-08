// lib/features/splash/presentation/pages/splash_view.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();

    // 👈 الانتقال تلقائياً إلى شاشة التحميل SplashLoadingView بعد ثانيتين
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/splash-loading');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // عرض الشاشة المرجعي في Figma هو 430
    final double screenWidth = MediaQuery.of(context).size.width;
    final double scale = screenWidth / 430.0;

    return Scaffold(
      backgroundColor: const Color(0xFF12292A), // لون الخلفية الداكن
      body: SafeArea(
        child: Stack(
          children: [
            // 1. النسر
            Positioned(
              top: 151 * scale,
              left: 81 * scale,
              width: 269 * scale,
              height: 150 * scale,
              child: const Image(
                image: AssetImage('assets/images/logo.png'),
                fit: BoxFit.contain,
              ),
            ),

            // 2. نص "شكوى"
            Positioned(
              top: 343 * scale,
              left: 171 * scale,
              width: 87 * scale,
              height: 36 * scale,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'شكوى',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.tajawal(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    height: 1.0,
                    color: const Color(0xFFFFFFFF),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
