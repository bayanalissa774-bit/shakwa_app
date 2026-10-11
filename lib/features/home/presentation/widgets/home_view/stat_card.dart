import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final double scale;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.color,
    required this.scale,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 12 * scale,
        horizontal: 8 * scale,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14 * scale),
        border: Border.all(color: const Color(0xFFD0D0D0), width: 1),
        boxShadow: const [
          BoxShadow(
            color: Color(0x26000000),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: GoogleFonts.tajawal(
              fontSize: 12 * scale,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF222222),
            ),
          ),
          SizedBox(height: 8 * scale),
          Text(
            value,
            style: GoogleFonts.tajawal(
              fontSize: 22 * scale,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: 6 * scale),
          Container(
            height: 3.5 * scale,
            width: double.infinity,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2 * scale),
            ),
          ),
        ],
      ),
    );
  }
}
