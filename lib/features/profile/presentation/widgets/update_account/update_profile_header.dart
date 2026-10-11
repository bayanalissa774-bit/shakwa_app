import 'dart:io';

import 'package:flutter/material.dart';

class UpdateProfileHeader extends StatelessWidget {
  final File? profileImage;
  final VoidCallback onPickImage;
  final double scale;
  final Color primaryColor;

  const UpdateProfileHeader({
    super.key,
    required this.profileImage,
    required this.onPickImage,
    required this.scale,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          CircleAvatar(
            radius: 45 * scale,
            backgroundColor: Colors.grey.shade200,
            backgroundImage: profileImage != null
                ? FileImage(profileImage!)
                : null,
            child: profileImage == null
                ? Icon(
                    Icons.person,
                    size: 45 * scale,
                    color: Colors.grey.shade400,
                  )
                : null,
          ),
          InkWell(
            onTap: onPickImage,
            child: Container(
              padding: EdgeInsets.all(6 * scale),
              decoration: BoxDecoration(
                color: primaryColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
