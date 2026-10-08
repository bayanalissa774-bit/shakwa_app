// lib/features/home/presentation/widgets/favorites_sheet.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shakwa_app/features/news/presentation/pages/news_details_page.dart';

void showFavoritesSheet(BuildContext context, double scale) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24 * scale)),
    ),
    builder: (context) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: EdgeInsets.all(20 * scale),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'الأخبار المفضلة',
                    style: GoogleFonts.tajawal(
                      fontSize: 18 * scale,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const Icon(Icons.favorite, color: Color(0xFFD4AF37)),
                ],
              ),
              SizedBox(height: 15 * scale),
              Divider(color: Colors.grey.shade300),
              SizedBox(height: 10 * scale),

              // خبر عينة في المفضلة
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NewsDetailsPage(),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(10 * scale),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(12 * scale),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8 * scale),
                        child: Image.asset(
                          'assets/images/news_item_thumb (1).png',
                          width: 60 * scale,
                          height: 60 * scale,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 12 * scale),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'مجلس الوزراء يطلق حزمة مبادرات جديدة',
                              style: GoogleFonts.tajawal(
                                fontSize: 13 * scale,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4 * scale),
                            Text(
                              'منذ ساعة واحدة',
                              style: GoogleFonts.tajawal(
                                fontSize: 11 * scale,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15 * scale),
            ],
          ),
        ),
      );
    },
  );
}
