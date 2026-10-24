// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeBannerCard extends StatelessWidget {
  final double scale;

  const HomeBannerCard({super.key, required this.scale});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360 * scale,
      height: 150 * scale,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20 * scale),
        border: Border.all(color: const Color(0xFF0C655E), width: 1.2),
        gradient: const LinearGradient(
          colors: [Color(0xFF0C655E), Color(0xFF1E6F67), Color(0xFF388E85)],
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x40000000),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'منصة الشكاوي الحكومية',
            style: GoogleFonts.tajawal(
              fontSize: 21 * scale,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8 * scale),
          Text(
            'تقديم ومتابعة الشكاوي بسهولة وشفافية',
            style: GoogleFonts.tajawal(
              fontSize: 13 * scale,
              fontWeight: FontWeight.w400,
              color: Colors.white.withOpacity(0.95),
            ),
          ),
        ],
      ),
    );
  }
}
