import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ComplaintCard extends StatelessWidget {
  final Map<String, String> complaint;
  final double scale;

  const ComplaintCard({
    super.key,
    required this.complaint,
    required this.scale,
  });

  @override
  Widget build(BuildContext context) {
    Color statusBgColor;

    if (complaint['status'] == 'مرفوضة') {
      statusBgColor = const Color(0xFFFF4D4D);
    } else if (complaint['status'] == 'قيد التنفيذ') {
      statusBgColor = const Color(0xFF1E88E5);
    } else {
      statusBgColor = const Color(0xFF00C853);
    }

    return Container(
      margin: EdgeInsets.only(bottom: 16 * scale),
      padding: EdgeInsets.all(16 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: Colors.grey.shade200, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  complaint['title']!,
                  style: GoogleFonts.tajawal(
                    fontSize: 16 * scale,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1E1E1E),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10 * scale,
                  vertical: 4 * scale,
                ),
                decoration: BoxDecoration(
                  color: statusBgColor,
                  borderRadius: BorderRadius.circular(12 * scale),
                ),
                child: Text(
                  complaint['status']!,
                  style: GoogleFonts.tajawal(
                    fontSize: 11 * scale,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8 * scale),
          Text(
            complaint['description']!,
            style: GoogleFonts.tajawal(
              fontSize: 13 * scale,
              color: Colors.grey.shade700,
              height: 1.5,
            ),
          ),
          SizedBox(height: 12 * scale),
          Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              complaint['date']!,
              style: GoogleFonts.tajawal(
                fontSize: 11 * scale,
                color: Colors.grey.shade500,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
