// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SupportExpandableCard extends StatelessWidget {
  final String title;
  final String content;
  final IconData icon;
  final double scale;

  const SupportExpandableCard({
    super.key,
    required this.title,
    required this.content,
    required this.icon,
    required this.scale,
  });

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF0C655E);

    return Container(
      margin: EdgeInsets.only(bottom: 16 * scale),
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16 * scale),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Material(
            color: Colors.transparent,
            child: ExpansionTile(
              iconColor: primaryColor,
              collapsedIconColor: primaryColor,
              leading: Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()..scale(-1.0, 1.0),
                child: Icon(icon, color: primaryColor, size: 24 * scale),
              ),
              title: Text(
                title,
                textAlign: TextAlign.right,
                style: GoogleFonts.tajawal(
                  fontSize: 15 * scale,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1E1E1E),
                ),
              ),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    16 * scale,
                    0,
                    16 * scale,
                    16 * scale,
                  ),
                  child: Text(
                    content,
                    textAlign: TextAlign.right,
                    style: GoogleFonts.tajawal(
                      fontSize: 13 * scale,
                      color: Colors.grey.shade700,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
