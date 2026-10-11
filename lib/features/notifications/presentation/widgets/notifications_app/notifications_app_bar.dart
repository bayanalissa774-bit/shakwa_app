import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final double scale;
  final VoidCallback onMarkAllAsRead;

  const NotificationsAppBar({
    super.key,
    required this.scale,
    required this.onMarkAllAsRead,
  });

  @override
  Size get preferredSize => Size.fromHeight(75 * scale);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF0C655E),
      elevation: 0,
      automaticallyImplyLeading: false,
      flexibleSpace: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16 * scale),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: onMarkAllAsRead,
                child: Row(
                  children: [
                    Text(
                      'تمييز الكل كـ مقروء',
                      style: GoogleFonts.tajawal(
                        fontSize: 11 * scale,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                    SizedBox(width: 4 * scale),
                    Icon(Icons.done_all, color: Colors.white, size: 16 * scale),
                  ],
                ),
              ),
              Text(
                "الإشعارات",
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
                    height: 44 * scale,
                    width: 80 * scale,
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
    );
  }
}
