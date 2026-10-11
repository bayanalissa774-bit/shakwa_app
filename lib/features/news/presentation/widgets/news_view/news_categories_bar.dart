import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsCategoriesBar extends StatelessWidget {
  final List<String> categories;
  final int selectedCategoryIndex;
  final ValueChanged<int> onCategorySelected;
  final double scale;
  final Color primaryColor;

  const NewsCategoriesBar({
    super.key,
    required this.categories,
    required this.selectedCategoryIndex,
    required this.onCategorySelected,
    required this.scale,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20 * scale),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(categories.length, (index) {
          final isSelected = selectedCategoryIndex == index;
          return InkWell(
            onTap: () => onCategorySelected(index),
            borderRadius: BorderRadius.circular(20 * scale),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(
                horizontal: 18 * scale,
                vertical: 8 * scale,
              ),
              decoration: BoxDecoration(
                color: isSelected ? primaryColor : Colors.transparent,
                borderRadius: BorderRadius.circular(20 * scale),
              ),
              child: Text(
                categories[index],
                style: GoogleFonts.tajawal(
                  fontSize: 14 * scale,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.white : primaryColor,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
