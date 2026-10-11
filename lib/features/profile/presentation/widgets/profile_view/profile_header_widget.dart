import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final File? profileImage;
  final VoidCallback onPickImage;
  final double scale;
  final Color primaryColor;
  final Color goldColor;

  const ProfileHeaderWidget({
    super.key,
    required this.profileImage,
    required this.onPickImage,
    required this.scale,
    required this.primaryColor,
    required this.goldColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Container(
              padding: EdgeInsets.all(4 * scale),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: goldColor.withValues(alpha: 0.6),
                  width: 2,
                ),
              ),
              child: CircleAvatar(
                radius: 50 * scale,
                backgroundColor: Colors.grey.shade200,
                backgroundImage: profileImage != null
                    ? FileImage(profileImage!)
                    : null,
                child: profileImage == null
                    ? Icon(
                        Icons.person,
                        size: 60 * scale,
                        color: Colors.grey.shade400,
                      )
                    : null,
              ),
            ),
            InkWell(
              onTap: onPickImage,
              child: Container(
                padding: EdgeInsets.all(8 * scale),
                decoration: BoxDecoration(
                  color: primaryColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Icon(Icons.add, color: Colors.white, size: 18 * scale),
              ),
            ),
          ],
        ),
        SizedBox(height: 16 * scale),
        Text(
          "Bayan Alissa",
          style: GoogleFonts.tajawal(
            fontSize: 22 * scale,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1E1E1E),
          ),
        ),
      ],
    );
  }
}
