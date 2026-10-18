import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ComplaintTextField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final double scale;

  const ComplaintTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    required this.scale,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.tajawal(
            fontSize: 14.5 * scale,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8 * scale),
        TextField(
          controller: controller,
          textAlign: TextAlign.right,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.tajawal(
              color: Colors.grey.shade400,
              fontSize: 12 * scale,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10 * scale),
            ),
          ),
        ),
      ],
    );
  }
}
