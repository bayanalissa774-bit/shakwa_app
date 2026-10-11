import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsCategoryChip extends StatelessWidget {
  final String label;
  final Color color;
  final double scale;

  const NewsCategoryChip({
    super.key,
    required this.label,
    required this.color,
    required this.scale,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 14 * scale,
        vertical: 6 * scale,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20 * scale),
        border: Border.all(color: color.withOpacity(0.2), width: 1),
      ),
      child: Text(
        label,
        style: GoogleFonts.tajawal(
          fontSize: 12 * scale,
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
