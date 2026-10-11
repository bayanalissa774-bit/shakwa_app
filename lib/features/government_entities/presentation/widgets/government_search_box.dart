import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GovernmentSearchBox extends StatelessWidget {
  final TextEditingController searchController;
  final VoidCallback onClear;
  final ValueChanged<String> onChanged;
  final VoidCallback onSearchPressed;
  final double scale;
  final Color primaryColor;

  const GovernmentSearchBox({
    super.key,
    required this.searchController,
    required this.onClear,
    required this.onChanged,
    required this.onSearchPressed,
    required this.scale,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20 * scale),
      padding: EdgeInsets.symmetric(horizontal: 16 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12 * scale),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          TextField(
            controller: searchController,
            textAlign: TextAlign.right,
            onChanged: onChanged,
            style: GoogleFonts.tajawal(
              fontSize: 14 * scale,
              color: const Color(0xFF1E1E1E),
            ),
            decoration: InputDecoration(
              hintText: 'البحث عن جهة حكومية....',
              hintStyle: GoogleFonts.tajawal(
                fontSize: 13 * scale,
                color: Colors.grey.shade400,
              ),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.grey.shade400,
                size: 22 * scale,
              ),
              suffixIcon: searchController.text.isNotEmpty
                  ? IconButton(
                      icon: Icon(
                        Icons.close,
                        color: Colors.grey.shade600,
                        size: 18 * scale,
                      ),
                      onPressed: onClear,
                    )
                  : null,
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 14 * scale),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 48 * scale,
            child: ElevatedButton(
              onPressed: onSearchPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10 * scale),
                ),
                elevation: 0,
              ),
              child: Text(
                'بحث',
                style: GoogleFonts.tajawal(
                  fontSize: 15 * scale,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: 12 * scale),
        ],
      ),
    );
  }
}
