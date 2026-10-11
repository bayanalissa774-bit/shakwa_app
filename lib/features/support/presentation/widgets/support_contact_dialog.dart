import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SupportContactDialog extends StatelessWidget {
  final double scale;

  const SupportContactDialog({super.key, required this.scale});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF0C655E);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20 * scale),
      ),
      backgroundColor: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(20 * scale),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'تواصل معنا عبر',
              style: GoogleFonts.tajawal(
                fontSize: 18 * scale,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: 20 * scale),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildSocialIcon(
                  icon: Icons.chat,
                  color: const Color(0xFF25D366),
                  label: 'واتساب',
                  scale: scale,
                  onTap: () {},
                ),
                _buildSocialIcon(
                  icon: Icons.facebook,
                  color: const Color(0xFF0084FF),
                  label: 'ماسنجر',
                  scale: scale,
                  onTap: () {},
                ),
                _buildSocialIcon(
                  icon: Icons.camera_alt,
                  color: const Color(0xFFE1306C),
                  label: 'انستغرام',
                  scale: scale,
                  onTap: () {},
                ),
                _buildSocialIcon(
                  icon: Icons.public,
                  color: const Color(0xFF1877F2),
                  label: 'فيسبوك',
                  scale: scale,
                  onTap: () {},
                ),
              ],
            ),
            SizedBox(height: 20 * scale),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'إغلاق',
                style: GoogleFonts.tajawal(
                  fontSize: 14 * scale,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialIcon({
    required IconData icon,
    required Color color,
    required String label,
    required double scale,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30 * scale),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(12 * scale),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 28 * scale),
          ),
          SizedBox(height: 6 * scale),
          Text(
            label,
            style: GoogleFonts.tajawal(
              fontSize: 11 * scale,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF1E1E1E),
            ),
          ),
        ],
      ),
    );
  }
}
