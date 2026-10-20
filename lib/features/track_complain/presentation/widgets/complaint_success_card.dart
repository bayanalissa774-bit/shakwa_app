import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/track_entity.dart'; // تأكدي من ضبط مسار الاستدعاء بحسب مجلدك

class ComplaintSuccessCard extends StatelessWidget {
  // 1. تعريف الحقل الذي سيحمل بيانات الشكوى القادمة من السيرفر
  final TrackEntity complaint;

  // 2. إضافته إلى الـ Constructor ليقبل الحقل 'complaint'
  const ComplaintSuccessCard({
    super.key,
    required this.complaint,
  });

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
                color: const Color(0xFFFFA000), // حالة الشكوى
                borderRadius: BorderRadius.circular(6 * scale),
              ),
              child: Text(
                complaint.status.isNotEmpty ? complaint.status : 'تحت المعالجة',
                style: GoogleFonts.tajawal(
                  fontSize: 12 * scale,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: 12 * scale),
          
          // استخدام القيم الحقيقية من كائن complaint القادم من الـ API
          _buildInfoRow('رقم الشكاوي :', complaint.id, scale),
          SizedBox(height: 10 * scale),
          _buildInfoRow('عنوان مختصر :', complaint.title, scale),
          SizedBox(height: 10 * scale),
          _buildInfoRow('اسم الجهة :', complaint.government, scale),
          SizedBox(height: 10 * scale),
          _buildInfoRow('التصنيف :', complaint.category, scale),
          SizedBox(height: 10 * scale),
          _buildInfoRow('تاريخ التقدم :', complaint.date, scale),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, double scale) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: GoogleFonts.tajawal(
              fontSize: 13.5 * scale,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF1E1E1E),
            ),
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