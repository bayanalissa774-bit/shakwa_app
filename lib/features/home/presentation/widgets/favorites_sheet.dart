import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void showFavoritesSheet(BuildContext context, double scale) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24 * scale)),
    ),
    builder: (context) {
      return Container(
        padding: EdgeInsets.all(20 * scale),
        height: 300 * scale,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40 * scale,
                height: 4 * scale,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2 * scale),
                ),
              ),
            ),
            SizedBox(height: 16 * scale),
            Text(
              'الأخبار المفضلة',
              style: GoogleFonts.tajawal(
                fontSize: 18 * scale,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0C655E),
              ),
            ),
            SizedBox(height: 12 * scale),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.newspaper,
                      color: Color(0xFF0C655E),
                    ),
                    title: Text(
                      'مجلس الوزراء يطلق حزمة مبادرات جديدة',
                      style: GoogleFonts.tajawal(fontSize: 14 * scale),
                    ),
                    subtitle: Text(
                      'منذ ساعة واحدة',
                      style: GoogleFonts.tajawal(fontSize: 11 * scale),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
