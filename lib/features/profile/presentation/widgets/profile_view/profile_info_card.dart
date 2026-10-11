import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileInfoCard extends StatelessWidget {
  final bool isExpanded;
  final VoidCallback onTap;
  final double scale;
  final Color primaryColor;

  const ProfileInfoCard({
    super.key,
    required this.isExpanded,
    required this.onTap,
    required this.scale,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 14 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(16 * scale),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16 * scale,
                vertical: 14 * scale,
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8 * scale),
                    decoration: BoxDecoration(
                      color: primaryColor.withValues(alpha: 0.08),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.person_outline_rounded,
                      color: primaryColor,
                      size: 20 * scale,
                    ),
                  ),
                  SizedBox(width: 12 * scale),
                  Expanded(
                    child: Text(
                      'المعلومات الشخصية',
                      style: GoogleFonts.tajawal(
                        fontSize: 15 * scale,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_down_rounded
                        : Icons.arrow_back_ios_rounded,
                    color: Colors.grey.shade400,
                    size: 18 * scale,
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded)
            Padding(
              padding: EdgeInsets.fromLTRB(
                16 * scale,
                0,
                16 * scale,
                16 * scale,
              ),
              child: Column(
                children: [
                  _buildInfoRow('رقم الهاتف:', '0933232322', scale),
                  _buildInfoRow(
                    'البريد الإلكتروني:',
                    'bayan.alissa111@gmail.com',
                    scale,
                  ),
                  _buildInfoRow('العنوان:', 'حلب المرديان', scale),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, double scale) {
    return Padding(
      padding: EdgeInsets.only(top: 8 * scale),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            value,
            style: GoogleFonts.tajawal(
              fontSize: 13 * scale,
              color: Colors.grey.shade600,
            ),
          ),
          SizedBox(width: 8 * scale),
          Text(
            label,
            style: GoogleFonts.tajawal(
              fontSize: 13 * scale,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
