import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EntityCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const EntityCard({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    final double scale = MediaQuery.of(context).size.width / 430.0;

    return Container(
      padding: EdgeInsets.all(14 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         
          Container(
            padding: EdgeInsets.all(8 * scale),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Icon(
              Icons.account_balance,
              size: 32 * scale,
              color: const Color(0xFF0C655E),
            ),
          ),
          SizedBox(height: 10 * scale),
          // عنوان الوزارة
          Text(
            title,
            style: GoogleFonts.tajawal(
              fontSize: 15 * scale,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1E1E1E),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 2 * scale),
          // التخصص أو الرعاية الفرعية
          Text(
            subtitle,
            style: GoogleFonts.tajawal(
              fontSize: 12 * scale,
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8 * scale),
          // سهم الانتقال الأنيق في الأسفل
          Align(
            alignment: Alignment.bottomLeft,
            child: Icon(
              Icons.arrow_forward,
              size: 18 * scale,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
