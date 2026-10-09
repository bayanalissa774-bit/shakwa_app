import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ComplaintErrorCard extends StatelessWidget {
  const ComplaintErrorCard({super.key});

  @override
  Widget build(BuildContext context) {
    final double scale = MediaQuery.of(context).size.width / 430.0;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16 * scale),
            decoration: BoxDecoration(
              color: Colors.red.withValues(alpha: 0.05),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.search_off_rounded,
              size: 40 * scale,
              color: Colors.grey.shade700,
            ),
          ),
          SizedBox(height: 16 * scale),
          Text(
            'لم يتم العثور على أي شكوى بهذا الرقم .',
            style: GoogleFonts.tajawal(
              fontSize: 16 * scale,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1E1E1E),
            ),
          ),
          SizedBox(height: 8 * scale),
          Text(
            'الرجاء التأكد من رقم الشكوى والمحاولة مرة أخرى .',
            textAlign: TextAlign.center,
            style: GoogleFonts.tajawal(
              fontSize: 13 * scale,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}
