import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthTextField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final bool obscureText;
  final Widget? suffixIcon;
  final double scale;

  const AuthTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.obscureText = false,
    this.suffixIcon,
    required this.scale,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            label,
            style: GoogleFonts.tajawal(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF000000),
            ),
          ),
        ),
        SizedBox(height: 6 * scale),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          textAlign: TextAlign.right,
          style: GoogleFonts.tajawal(fontSize: 14),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return '';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.tajawal(
              fontSize: 12,
              color: const Color(0xFFA1A1A1),
            ),
            filled: true,
            fillColor: const Color(0xFFFFFFFF),
            contentPadding: EdgeInsets.symmetric(
              vertical: 10 * scale,
              horizontal: 9 * scale,
            ),
            suffixIcon: suffixIcon,
            errorStyle: const TextStyle(height: 0, fontSize: 0),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFF01322E), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color(0xFF0C655E),
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}
