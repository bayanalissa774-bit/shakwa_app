import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ComplaintDescriptionWidget extends StatelessWidget {
  final TextEditingController controller;
  final bool isExpanded;

  final double scale;

  const ComplaintDescriptionWidget({
    super.key,
    required this.controller,
    required this.isExpanded,

    required this.scale,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: isExpanded ? null : 4,
      textAlign: TextAlign.right,
      style: GoogleFonts.tajawal(fontSize: 13 * scale),
      decoration: InputDecoration(
        hintText: 'اكتب تفاصيل المشكلة هنا بشكل مفصل............... ',
        hintStyle: GoogleFonts.tajawal(
          color: Colors.grey.shade400,
          fontSize: 12 * scale,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 12 * scale,
          vertical: 10 * scale,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10 * scale),
          borderSide: const BorderSide(color: Color(0xFF707070)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10 * scale),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
      ),
    );
  }
}
