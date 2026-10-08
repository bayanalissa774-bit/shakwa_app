// lib/features/splash/presentation/pages/splash_loading_view.dart

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class SplashLoadingView extends StatefulWidget {
  const SplashLoadingView({super.key});

  @override
  State<SplashLoadingView> createState() => _SplashLoadingViewState();
}

class _SplashLoadingViewState extends State<SplashLoadingView> {
  @override
  void initState() {
    super.initState();

    // 👈 الانتقال لشاشة تسجيل الدخول بعد ثانيتين
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double scale = screenWidth / 430.0;

    return Scaffold(
      backgroundColor: const Color(0xFF12292A),
      body: SafeArea(
        child: Stack(
          children: [
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
            Positioned(
              top: 577 * scale,
              left: 185 * scale,
              width: 60 * scale,
              height: 60 * scale,
              child: const CircularProgressIndicator(
                strokeWidth: 4.0,
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFF2C994)),
                backgroundColor: Color(0x33F2C994),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
