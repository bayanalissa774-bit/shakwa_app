import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hint;
  final double scale;
  final bool obscure;
  final TextInputType type;

  const CustomTextFieldWidget({
    super.key,
    required this.label,
    required this.controller,
    required this.hint,
    required this.scale,
    this.obscure = false,
    this.type = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: GoogleFonts.tajawal(
            fontSize: 13 * scale,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 6 * scale),
        TextFormField(
          controller: controller,
          obscureText: obscure,
          keyboardType: type,
          textAlign: TextAlign.right,
          style: GoogleFonts.tajawal(fontSize: 14 * scale),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: hint,
            hintStyle: GoogleFonts.tajawal(
              fontSize: 13 * scale,
              color: Colors.grey.shade400,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16 * scale,
              vertical: 14 * scale,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12 * scale),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12 * scale),
              borderSide: const BorderSide(
                color: Color(0xFF0C655E),
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12 * scale),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12 * scale),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),
          ),
          validator: (v) => v == null || v.isEmpty ? 'هذا الحقل مطلوب' : null,
        ),
        SizedBox(height: 14 * scale),
      ],
    );
  }
}
