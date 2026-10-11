import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsDetailsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double scale;
  final Color primaryColor;

  const NewsDetailsAppBar({
    super.key,
    required this.scale,
    required this.primaryColor,
  });

  @override
  Size get preferredSize => Size.fromHeight(75 * scale);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: primaryColor,
      elevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      toolbarHeight: 75 * scale,
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16 * scale),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => Navigator.pop(context),
              borderRadius: BorderRadius.circular(20 * scale),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 8 * scale,
                  vertical: 4 * scale,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                      size: 18 * scale,
                    ),
                    SizedBox(width: 6 * scale),
                    Text(
                      'رجوع',
                      style: GoogleFonts.tajawal(
                        fontSize: 15 * scale,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Text(
              'تفاصيل الخبر',
              style: GoogleFonts.tajawal(
                fontSize: 18 * scale,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(20 * scale),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 8 * scale,
                  vertical: 4 * scale,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'مزيد',
                      style: GoogleFonts.tajawal(
                        fontSize: 15 * scale,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 4 * scale),
                    const Icon(Icons.more_vert, color: Colors.white, size: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      titleSpacing: 0,
    );
  }
}
