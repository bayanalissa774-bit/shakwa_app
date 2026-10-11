import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeAppBar extends StatelessWidget {
  final double scale;

  const HomeAppBar({super.key, required this.scale});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100 * scale,
      color: const Color(0xFF0C655E),
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Stack(
        children: [
          Positioned(
            left: 16 * scale,
            top: 8 * scale,
            bottom: 8 * scale,
            width: 81 * scale,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: 44 * scale,
                    width: 80 * scale,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.shield,
                      color: const Color(0xFFD4AF37),
                      size: 37 * scale,
                    ),
                  ),
                ),
                SizedBox(height: 3 * scale),
                Text(
                  'شكوى',
                  style: GoogleFonts.tajawal(
                    fontSize: 10 * scale,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    height: 0.1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
