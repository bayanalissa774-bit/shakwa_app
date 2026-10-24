// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';

class AuthInputField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller;
  final bool isPassword;
  final bool readOnly;
  final VoidCallback? onTap;
  final Widget? prefixIcon; // <-- أضفنا هذا السطر هنا

  const AuthInputField({
    Key? key,
    required this.label,
    required this.hintText,
    this.controller,
    this.isPassword = false,
    this.readOnly = false,
    this.onTap,
    this.prefixIcon, // <-- وأضفناه هنا في البناء
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            obscureText: isPassword,
            readOnly: readOnly,
            onTap: onTap,
            textDirection: TextDirection.rtl, // اتجاه الكتابة من اليمين لليسار
            textAlign: TextAlign.right, // محاذاة النص لليمين
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'هذا الحقل مطلوب';
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: hintText,
              hintTextDirection: TextDirection.rtl, // اتجاه الـ Hint من اليمين
              prefixIcon: prefixIcon,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
