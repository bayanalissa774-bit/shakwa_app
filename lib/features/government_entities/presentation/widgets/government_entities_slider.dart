import 'package:flutter/material.dart';
import 'package:shakwa_app/features/government_entities/domain/entities/government_entity.dart';
import 'package:shakwa_app/features/government_entities/presentation/widgets/entity_card.dart';

class GovernmentEntitiesSlider extends StatelessWidget {
  final List<GovernmentEntity> entities;
  final PageController pageController;
  final ValueChanged<int> onPageChanged;
  final double scale;

  const GovernmentEntitiesSlider({
    super.key,
    required this.entities,
    required this.pageController,
    required this.onPageChanged,
    required this.scale,
  });

  @override
  Widget build(BuildContext context) {
    // نحدد عدد العناصر في كل صفحة (مثلاً 4 بطاقات لكل صفحة)
    const int itemsPerPage = 4;
    final int pageCount = (entities.length / itemsPerPage).ceil();

    return SizedBox(
      height: 380 * scale,
      child: PageView.builder(
        controller: pageController,
        onPageChanged: onPageChanged,
        itemCount: pageCount == 0 ? 1 : pageCount,
        itemBuilder: (context, pageIndex) {
          final int startIndex = pageIndex * itemsPerPage;
          final int endIndex = (startIndex + itemsPerPage < entities.length)
              ? startIndex + itemsPerPage
              : entities.length;

          final pageEntities = entities.sublist(startIndex, endIndex);

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20 * scale),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16 * scale,
                mainAxisSpacing: 16 * scale,
                childAspectRatio: 1.1,
              ),
              itemCount: pageEntities.length,
              itemBuilder: (context, index) {
                final entity = pageEntities[index];
                return EntityCard(
                  title: entity.name,
                  subtitle: entity.description,
                  onTap: () {
                    // عند الضغط على البطاقة (مثلاً الانتقال لصفحة تفاصيل الجهة)
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}