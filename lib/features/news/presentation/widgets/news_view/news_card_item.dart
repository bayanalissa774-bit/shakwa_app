import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsCardItem extends StatelessWidget {
  final Map<String, String> item;
  final VoidCallback onTap;
  final double scale;

  const NewsCardItem({
    super.key,
    required this.item,
    required this.onTap,
    required this.scale,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16 * scale),
      child: Container(
        margin: EdgeInsets.only(bottom: 16 * scale),
        padding: EdgeInsets.all(12 * scale),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16 * scale),
          boxShadow: const [
            BoxShadow(
              color: Color(0x11000000),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12 * scale),
              child: Image.asset(
                item['image']!,
                width: 80 * scale,
                height: 80 * scale,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 80 * scale,
                  height: 80 * scale,
                  color: Colors.grey[300],
                  child: const Icon(Icons.image, color: Colors.grey),
                ),
              ),
            ),
            SizedBox(width: 12 * scale),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14 * scale,
                      vertical: 3 * scale,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFCDCDC),
                      borderRadius: BorderRadius.circular(12 * scale),
                    ),
                    child: Text(
                      item['tag']!,
                      style: GoogleFonts.tajawal(
                        fontSize: 11 * scale,
                        color: const Color(0xFFD32F2F),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 8 * scale),
                  Text(
                    item['title']!,
                    style: GoogleFonts.tajawal(
                      fontSize: 13 * scale,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    item['subtitle']!,
                    style: GoogleFonts.tajawal(
                      fontSize: 11 * scale,
                      color: Colors.grey[600],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8 * scale),
                  Text(
                    item['time']!,
                    style: GoogleFonts.tajawal(
                      fontSize: 10 * scale,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
