import 'package:flutter/material.dart';

class NewsBannerSlider extends StatelessWidget {
  final PageController pageController;
  final List<String> bannerImages;
  final int bannerIndex;
  final ValueChanged<int> onPageChanged;
  final double scale;
  final Color primaryColor;

  const NewsBannerSlider({
    super.key,
    required this.pageController,
    required this.bannerImages,
    required this.bannerIndex,
    required this.onPageChanged,
    required this.scale,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 290 * scale,
          child: PageView.builder(
            controller: pageController,
            itemCount: bannerImages.length,
            onPageChanged: onPageChanged,
            itemBuilder: (context, index) {
              final isSelected = index == bannerIndex;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: EdgeInsets.symmetric(
                  horizontal: 6 * scale,
                  vertical: isSelected ? 0 : 10 * scale,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20 * scale),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x26000000),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20 * scale),
                  child: Image.asset(
                    bannerImages[index],
                    fit: BoxFit.fill,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: primaryColor,
                      child: const Center(
                        child: Icon(
                          Icons.newspaper,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 12 * scale),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            bannerImages.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: bannerIndex == index ? 22 * scale : 8 * scale,
              height: 8 * scale,
              decoration: BoxDecoration(
                color: bannerIndex == index
                    ? primaryColor
                    : const Color(0xFFBDBDBD),
                borderRadius: BorderRadius.circular(4 * scale),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
