import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdateIdCardPicker extends StatelessWidget {
  final File? idImage;
  final bool submitted;
  final VoidCallback onPickIdImage;
  final double scale;
  final Color primaryColor;

  const UpdateIdCardPicker({
    super.key,
    required this.idImage,
    required this.submitted,
    required this.onPickIdImage,
    required this.scale,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasError = submitted && idImage == null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'ادخل صورة عن الهوية',
          style: GoogleFonts.tajawal(
            fontSize: 13 * scale,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 6 * scale),
        GestureDetector(
          onTap: onPickIdImage,
          child: Container(
            height: 50 * scale,
            padding: EdgeInsets.symmetric(horizontal: 16 * scale),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12 * scale),
              border: Border.all(
                color: hasError ? Colors.red : Colors.grey.shade300,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.upload_file,
                  color: hasError ? Colors.red : primaryColor,
                  size: 20,
                ),
                SizedBox(width: 12 * scale),
                Expanded(
                  child: Text(
                    idImage != null
                        ? 'تم اختيار صورة الهوية بنجاح'
                        : 'تغيير صورة الهوية',
                    textAlign: TextAlign.right,
                    style: GoogleFonts.tajawal(
                      fontSize: 13 * scale,
                      color: idImage != null
                          ? primaryColor
                          : Colors.grey.shade600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(top: 4, right: 8),
            child: Text(
              'يرجى اختيار صورة الهوية',
              style: GoogleFonts.tajawal(fontSize: 11, color: Colors.red),
            ),
          ),
      ],
    );
  }
}
