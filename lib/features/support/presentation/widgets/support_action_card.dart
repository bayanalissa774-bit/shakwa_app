import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SupportActionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final double scale;

  const SupportActionCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    required this.scale,
  });

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF0C655E);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16 * scale),
      child: Container(
        margin: EdgeInsets.only(bottom: 16 * scale),
        padding: EdgeInsets.all(16 * scale),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16 * scale),
          border: Border.all(color: const Color(0xFF4A90E2), width: 1.2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.arrow_back_ios_rounded,
              color: primaryColor,
              size: 18 * scale,
            ),
            Row(
              children: [
                Text(
                  title,
                  style: GoogleFonts.tajawal(
                    fontSize: 15 * scale,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1E1E1E),
                  ),
                ),
                SizedBox(width: 12 * scale),
                Icon(icon, color: primaryColor, size: 24 * scale),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
