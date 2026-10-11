import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ComplaintFilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final double scale;
  final Color primaryColor;

  const ComplaintFilterChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.scale,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20 * scale),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16 * scale,
          vertical: 8 * scale,
        ),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20 * scale),
          border: Border.all(
            color: isSelected ? primaryColor : Colors.grey.shade300,
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.tajawal(
            fontSize: 13 * scale,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : Colors.grey.shade700,
          ),
        ),
      ),
    );
  }
}
