import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileMenuItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final double scale;
  final Color primaryColor;
  final VoidCallback onTap;

  const ProfileMenuItem({
    super.key,
    required this.title,
    required this.icon,
    required this.scale,
    required this.primaryColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 14 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16 * scale),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16 * scale,
            vertical: 14 * scale,
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8 * scale),
                decoration: BoxDecoration(
                  color: primaryColor.withValues(alpha: 0.08),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: primaryColor, size: 20 * scale),
              ),
              SizedBox(width: 12 * scale),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.tajawal(
                    fontSize: 15 * scale,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.grey.shade400,
                size: 16 * scale,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
