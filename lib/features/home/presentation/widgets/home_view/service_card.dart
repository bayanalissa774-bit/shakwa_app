import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ServiceCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final double scale;
  final VoidCallback onTap;

  const ServiceCard({
    super.key,
    required this.title,
    required this.icon,
    required this.scale,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16 * scale),
      child: Container(
        height: 110 * scale,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16 * scale),
          border: Border.all(color: const Color(0xFF1E1E1E), width: 1),
          boxShadow: const [
            BoxShadow(
              color: Color(0x33000000),
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30 * scale, color: const Color(0xFF0C655E)),
            SizedBox(height: 10 * scale),
            Text(
              title,
              style: GoogleFonts.tajawal(
                fontSize: 14 * scale,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF000000),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
