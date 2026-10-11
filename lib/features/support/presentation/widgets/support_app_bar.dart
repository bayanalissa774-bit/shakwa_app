import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shakwa_app/features/home/presentation/pages/home_view.dart';

class SupportAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double scale;

  const SupportAppBar({super.key, required this.scale});

  @override
  Size get preferredSize => Size.fromHeight(75 * scale);

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF0C655E);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        flexibleSpace: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16 * scale),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeView()),
                      (route) => false,
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 20 * scale,
                      ),
                      SizedBox(width: 4 * scale),
                      Text(
                        'رجوع',
                        style: GoogleFonts.tajawal(
                          fontSize: 16 * scale,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'الدعم والمساعدة',
                  style: GoogleFonts.tajawal(
                    fontSize: 17 * scale,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      height: 42 * scale,
                      width: 83 * scale,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.shield,
                        color: const Color(0xFFD4AF37),
                        size: 37 * scale,
                      ),
                    ),
                    SizedBox(height: 3 * scale),
                    Text(
                      'شكوى',
                      style: GoogleFonts.tajawal(
                        fontSize: 10 * scale,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
