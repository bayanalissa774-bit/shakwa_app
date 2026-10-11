import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsBookmarkButton extends StatelessWidget {
  final bool isBookmarked;
  final VoidCallback onTap;
  final double scale;
  final Color primaryColor;

  const NewsBookmarkButton({
    super.key,
    required this.isBookmarked,
    required this.onTap,
    required this.scale,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20 * scale),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: EdgeInsets.symmetric(
            horizontal: 26 * scale,
            vertical: 12 * scale,
          ),
          decoration: BoxDecoration(
            color: isBookmarked
                ? const Color(0xFFFFF8E1)
                : primaryColor.withOpacity(0.06),
            borderRadius: BorderRadius.circular(20 * scale),
            border: Border.all(
              color: isBookmarked
                  ? const Color(0xFFFFB300)
                  : primaryColor.withOpacity(0.2),
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isBookmarked ? Icons.favorite : Icons.favorite_border,
                color: isBookmarked ? const Color(0xFFFFA000) : primaryColor,
                size: 22 * scale,
              ),
              SizedBox(width: 10 * scale),
              Text(
                isBookmarked ? 'تمت الإضافة للمفضلة' : 'إضافة للمفضلة',
                style: GoogleFonts.tajawal(
                  fontSize: 15 * scale,
                  fontWeight: FontWeight.bold,
                  color: isBookmarked ? const Color(0xFF8D6E63) : primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
