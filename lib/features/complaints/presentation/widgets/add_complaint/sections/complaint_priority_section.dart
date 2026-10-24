// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ComplaintPrioritySection extends StatelessWidget {
  final String selectedPriority;
  final double scale;
  final Function(String priority) onPrioritySelected;

  const ComplaintPrioritySection({
    super.key,
    required this.selectedPriority,
    required this.scale,
    required this.onPrioritySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'درجة الأولوية',
          style: GoogleFonts.tajawal(
            fontSize: 14.5 * scale,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8 * scale),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildPriorityButton('عالية', const Color(0xFFFF5252)),
            _buildPriorityButton('متوسطة', const Color(0xFFFFC107)),
            _buildPriorityButton('منخفضة', const Color(0xFF00C853)),
          ],
        ),
      ],
    );
  }

  Widget _buildPriorityButton(String title, Color activeColor) {
    final bool isSelected = selectedPriority == title;
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4 * scale),
        child: OutlinedButton(
          onPressed: () => onPrioritySelected(title),
          style: OutlinedButton.styleFrom(
            side: BorderSide(
              color: isSelected ? activeColor : Colors.grey.shade400,
              width: isSelected ? 2 : 1,
            ),
            backgroundColor: isSelected
                ? activeColor.withOpacity(0.1)
                : Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20 * scale),
            ),
            padding: EdgeInsets.symmetric(vertical: 10 * scale),
          ),
          child: Text(
            title,
            style: GoogleFonts.tajawal(
              fontSize: 13 * scale,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? activeColor : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
