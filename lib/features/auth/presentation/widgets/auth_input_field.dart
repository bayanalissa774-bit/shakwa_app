import 'package:flutter/material.dart';

class AuthInputField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final bool isPassword;
  final Widget? prefixIcon;
  final bool readOnly;
  final VoidCallback? onTap;

  const AuthInputField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.isPassword = false,
    this.prefixIcon,
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Cairo',
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: isPassword,
          readOnly: readOnly,
          onTap: onTap,
          textAlign: TextAlign.right,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return '';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              fontFamily: 'Cairo',
              color: Colors.grey,
              fontSize: 13,
            ),
            prefixIcon: prefixIcon,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFF4A6B6C)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFF0E6655), width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color(0xFFFF5252),
                width: 1.5,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFFFF5252), width: 2),
            ),
            errorStyle: const TextStyle(height: 0),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
