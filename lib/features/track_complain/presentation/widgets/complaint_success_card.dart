import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ComplaintSuccessCard extends StatelessWidget {
  const ComplaintSuccessCard({super.key});

  @override
  Widget build(BuildContext context) {
    final double scale = MediaQuery.of(context).size.width / 430.0;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20 * scale),
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
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 12 * scale,
                vertical: 6 * scale,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFFFA000), // برتقالي تحت المعالجة
                borderRadius: BorderRadius.circular(6 * scale),
              ),
              child: Text(
                'تحت المعالجة',
                style: GoogleFonts.tajawal(
                  fontSize: 12 * scale,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: 12 * scale),
          _buildInfoRow('رقم الشكاوي :', '20240101501', scale),
          SizedBox(height: 10 * scale),
          _buildInfoRow('عنوان مختصر :', 'صيانة إنارة الطريق', scale),
          SizedBox(height: 10 * scale),
          _buildInfoRow(
            'اسم الجهة :',
            'بلدية حلب _ أمانة منطقة المرديان',
            scale,
          ),
          SizedBox(height: 10 * scale),
          _buildInfoRow('التصنيف :', 'صيانة طريق', scale),
          SizedBox(height: 10 * scale),
          _buildInfoRow('تاريخ التقدم :', '15 أكتوبر 2026', scale),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, double scale) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          value,
          style: GoogleFonts.tajawal(
            fontSize: 13.5 * scale,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF1E1E1E),
          ),
        ),
        SizedBox(width: 8 * scale),
        Text(
          label,
          style: GoogleFonts.tajawal(
            fontSize: 13.5 * scale,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1E1E1E),
          ),
        ),
      ],
    );
  }
}
