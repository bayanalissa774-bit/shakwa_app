import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shakwa_app/features/news/presentation/cubit/news_cubit.dart';
import 'package:shakwa_app/features/news/presentation/cubit/news_state.dart';
import 'package:shakwa_app/features/news/presentation/widgets/news_view/news_card_item.dart';

class NewsListSection extends StatelessWidget {
  final double scale;
  final Color primaryColor;
  final String selectedCategory; // 👈 استقبال التصنيف المختار

  const NewsListSection({
    super.key,
    required this.scale,
    required this.primaryColor,
    required this.selectedCategory,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsCubit, NewsState>(
      builder: (context, state) {
        if (state is NewsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is NewsLoaded) {
          // فلترة قائمة الأخبار بناءً على التصنيف المحدد
          final filteredNews = state.news.where((newsItem) {
            if (selectedCategory == 'الكل') {
              return true; // عرض جميع الأخبار
            }

            final tag = newsItem.tag.trim();
            final title = newsItem.title.trim();
            final subtitle = newsItem.subtitle.trim();
            final category = selectedCategory.trim();

            return tag.contains(category) ||
                title.contains(category) ||
                subtitle.contains(category) ||
                (category == 'تنبيهات' &&
                    (tag.contains('عادية') || tag.contains('مهمة'))) ||
                (category == 'خدمات' &&
                    (tag.contains('متوسطة') || tag.contains('خدمة'))) ||
                (category == 'إنجازات' &&
                    (tag.contains('منخفضة') || tag.contains('إنجاز')));
          }).toList();

          if (filteredNews.isEmpty) {
            return Padding(
              padding: EdgeInsets.all(20.0 * scale),
              child: Text(
                'لا توجد أخبار تندرج تحت تصنيف "$selectedCategory"',
                style: GoogleFonts.tajawal(
                  fontSize: 14 * scale,
                  color: Colors.grey,
                ),
              ),
            );
          }

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filteredNews.length,
            itemBuilder: (context, index) {
              final item = filteredNews[index];
              return NewsCardItem(
                news: item,
                scale: scale,
                primaryColor: primaryColor,
              );
            },
          );
        } else if (state is NewsError) {
          return Center(
            child: Text(
              state.message,
              style: GoogleFonts.tajawal(color: Colors.red),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
