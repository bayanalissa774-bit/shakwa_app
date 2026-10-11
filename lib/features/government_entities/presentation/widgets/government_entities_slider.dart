import 'package:flutter/material.dart';
import 'package:shakwa_app/features/government_entities/presentation/widgets/entity_card.dart';

class GovernmentEntitiesSlider extends StatelessWidget {
  final PageController pageController;
  final ValueChanged<int> onPageChanged;
  final double scale;

  const GovernmentEntitiesSlider({
    super.key,
    required this.pageController,
    required this.onPageChanged,
    required this.scale,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 380 * scale,
      child: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        children: [
          _buildGridPage(scale, const [
            EntityCard(title: 'وزارة الصحة', subtitle: 'الرعاية الصحية'),
            EntityCard(title: 'وزارة الداخلية', subtitle: 'خدمات المواطنين'),
            EntityCard(title: 'وزارة التربية', subtitle: 'التعليم الأساسي'),
            EntityCard(title: 'وزارة العدل', subtitle: 'الخدمات العدلية'),
          ]),
          _buildGridPage(scale, const [
            EntityCard(title: 'وزارة التربية', subtitle: 'التعليم الأساسي'),
            EntityCard(title: 'وزارة التعليم', subtitle: 'التعليم العالي'),
            EntityCard(title: 'وزارة الداخلية', subtitle: 'خدمات المواطنين'),
            EntityCard(title: 'وزارة العدل', subtitle: 'الخدمات العدلية'),
          ]),
          _buildGridPage(scale, const [
            EntityCard(title: 'وزارة المالية', subtitle: 'الضرائب والرسوم'),
            EntityCard(title: 'وزارة النقل', subtitle: 'النقل البري والبحري'),
            EntityCard(title: 'وزارة الإدارة', subtitle: 'شؤون البلديات'),
            EntityCard(title: 'وزارة الاتصالات', subtitle: 'التحول الرقمي'),
          ]),
        ],
      ),
    );
  }

  Widget _buildGridPage(double scale, List<Widget> children) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20 * scale),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 16 * scale,
        mainAxisSpacing: 16 * scale,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: children,
      ),
    );
  }
}
