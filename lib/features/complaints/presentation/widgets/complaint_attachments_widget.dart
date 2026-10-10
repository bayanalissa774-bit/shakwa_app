import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ComplaintAttachmentsWidget extends StatelessWidget {
  final List<dynamic>
  images; // تدعم مسارات الـ asset (String) أو الملفات المحلية (File)
  final VoidCallback onAddImageTap;
  final double scale;

  const ComplaintAttachmentsWidget({
    super.key,
    required this.images,
    required this.onAddImageTap,
    required this.scale,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75 * scale,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          // 1. زر إضافة صورة التفاعلي
          InkWell(
            onTap: onAddImageTap,
            child: Container(
              width: 80 * scale,
              height: 75 * scale,
              decoration: BoxDecoration(
                color: const Color(0xFFE0E0E0),
                borderRadius: BorderRadius.circular(10 * scale),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add, size: 24 * scale, color: Colors.black87),
                  SizedBox(height: 2 * scale),
                  Text(
                    'اضافة صورة',
                    style: GoogleFonts.tajawal(
                      fontSize: 10.5 * scale,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 8 * scale),

          // 2. عرض الصور (سواء كانت ملفات مختارة من الجهاز أو مسارات أصول)
          ...images.map((img) {
            return Padding(
              padding: EdgeInsets.only(left: 8 * scale),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10 * scale),
                child: img is File
                    ? Image.file(
                        img,
                        width: 80 * scale,
                        height: 75 * scale,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        img.toString(),
                        width: 80 * scale,
                        height: 75 * scale,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 80 * scale,
                          height: 75 * scale,
                          color: Colors.grey.shade300,
                          child: const Icon(Icons.image, color: Colors.grey),
                        ),
                      ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
