import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationCard extends StatelessWidget {
  final Map<String, dynamic> item;
  final double scale;
  final Color primaryColor;

  const NotificationCard({
    super.key,
    required this.item,
    required this.scale,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    final bool isRead = item['isRead'];

    return Container(
      margin: EdgeInsets.only(bottom: 14 * scale),
      padding: EdgeInsets.symmetric(
        horizontal: 16 * scale,
        vertical: 14 * scale,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(
          color: isRead
              ? Colors.grey.shade200
              : primaryColor.withValues(alpha: 0.4),
          width: isRead ? 1 : 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // نقطة الإشعار غير المقروء
          if (!isRead)
            Container(
              width: 8 * scale,
              height: 8 * scale,
              margin: EdgeInsets.only(left: 12 * scale),
              decoration: const BoxDecoration(
                color: Color(0xFF00C853),
                shape: BoxShape.circle,
              ),
            )
          else
            SizedBox(width: 20 * scale),

          // النصوص (العنوان ووقت الإشعار)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['title'],
                  style: GoogleFonts.tajawal(
                    fontSize: 15 * scale,
                    fontWeight: isRead ? FontWeight.normal : FontWeight.bold,
                    color: const Color(0xFF1E1E1E),
                  ),
                ),
                SizedBox(height: 4 * scale),
                Text(
                  item['time'],
                  style: GoogleFonts.tajawal(
                    fontSize: 12 * scale,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),

          // أيقونة الإشعار الدائرية المميزة
          Container(
            padding: EdgeInsets.all(10 * scale),
            decoration: BoxDecoration(
              color: primaryColor.withValues(alpha: 0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(item['icon'], color: primaryColor, size: 22 * scale),
          ),
        ],
      ),
    );
  }
}
