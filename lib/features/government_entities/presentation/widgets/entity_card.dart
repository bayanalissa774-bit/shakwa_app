import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EntityCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const EntityCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double scale = MediaQuery.of(context).size.width / 430.0;
    const Color primaryColor = Color(0xFF0C655E);

    return InkWell(
      onTap: onTap ?? () {},
      borderRadius: BorderRadius.circular(16 * scale),
      child: Container(
        padding: EdgeInsets.all(16 * scale),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16 * scale),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(12 * scale),
              decoration: BoxDecoration(
                color: primaryColor.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.account_balance,
                color: primaryColor,
                size: 28 * scale,
              ),
            ),
            SizedBox(height: 12 * scale),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.tajawal(
                fontSize: 14 * scale,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1E1E1E),
              ),
            ),
            SizedBox(height: 4 * scale),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: GoogleFonts.tajawal(
                fontSize: 11 * scale,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
