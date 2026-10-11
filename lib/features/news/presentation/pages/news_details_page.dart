import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shakwa_app/features/news/presentation/widgets/news_details/news_bookmark_button.dart';
import 'package:shakwa_app/features/news/presentation/widgets/news_details/news_category_chip.dart';
import 'package:shakwa_app/features/news/presentation/widgets/news_details/news_details_app_bar.dart';

class NewsDetailsPage extends StatefulWidget {
  final String? title;
  final String? date;
  final String? imagePath;
  final String? content;

  const NewsDetailsPage({
    super.key,
    this.title,
    this.date,
    this.imagePath,
    this.content,
  });

  @override
  State<NewsDetailsPage> createState() => _NewsDetailsPageState();
}

class _NewsDetailsPageState extends State<NewsDetailsPage> {
  bool _isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double scale = screenWidth / 430.0;

    const Color primaryColor = Color(0xFF0C655E);
    const Color accentRed = Color(0xFFE53935);
    const Color textDark = Color(0xFF111827);

    final String displayTitle =
        widget.title ??
        'مجلس الوزراء يطلق حزمة مبادرات جديدة لدعم الشباب والابتكار';
    final String displayDate = widget.date ?? '15 أكتوبر 2025 ، 10:00 صباحاً';
    final String displayImage =
        widget.imagePath ?? 'assets/images/news_detail_banner.png';

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: NewsDetailsAppBar(scale: scale, primaryColor: primaryColor),
        body: ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(45 * scale)),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                expandedHeight: 270.0 * scale,
                pinned: false,
                floating: false,
                backgroundColor: Colors.white,
                elevation: 0,
                automaticallyImplyLeading: false,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.asset(
                    displayImage,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey.shade200,
                      child: const Center(
                        child: Icon(Icons.image, color: Colors.grey, size: 50),
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Transform.translate(
                  offset: Offset(0.0, -32.0 * scale),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(45 * scale),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 16,
                          offset: const Offset(0, -6),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.fromLTRB(
                      24 * scale,
                      36 * scale,
                      24 * scale,
                      30 * scale,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            NewsCategoryChip(
                              label: 'الأخبار المحلية',
                              color: primaryColor,
                              scale: scale,
                            ),
                            SizedBox(width: 10 * scale),
                            NewsCategoryChip(
                              label: 'هام',
                              color: accentRed,
                              scale: scale,
                            ),
                          ],
                        ),
                        SizedBox(height: 18 * scale),
                        Text(
                          displayTitle,
                          style: GoogleFonts.tajawal(
                            fontSize: 22 * scale,
                            fontWeight: FontWeight.bold,
                            color: textDark,
                            height: 1.45,
                          ),
                        ),
                        SizedBox(height: 14 * scale),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(6 * scale),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF3F4F6),
                                borderRadius: BorderRadius.circular(8 * scale),
                              ),
                              child: Icon(
                                Icons.calendar_today_rounded,
                                size: 14 * scale,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(width: 10 * scale),
                            Text(
                              displayDate,
                              style: GoogleFonts.tajawal(
                                fontSize: 13 * scale,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 22 * scale),
                        Divider(color: Colors.grey.shade100, thickness: 1.5),
                        SizedBox(height: 22 * scale),
                        Text(
                          widget.content ??
                              'في إطار الجمهورية العربية السورية لتعزيز بيئة ريادة الأعمال، أعلن رئيس الوزراء اليوم عن إطلاق برنامج شامل يهدف لتقديم دعم فني ومالي للمشاريع والابتكارات الشبابية في كل القطاعات المحلية تتضمن جميع نشاطات وإدارة الأعمال المفهومية واللوجستية.\n\n'
                                  'في إطار الجمهورية العربية السورية لتعزيز بيئة ريادة الأعمال، أعلن رئيس الوزراء اليوم عن إطلاق برنامج شامل يهدف لتقديم دعم فني ومالي للمشاريع والابتكارات الشبابية في كل القطاعات المحلية تتضمن جميع نشاطات وإدارة الأعمال المفهومية واللوجستية.',
                          style: GoogleFonts.tajawal(
                            fontSize: 15.5 * scale,
                            color: Colors.grey.shade800,
                            height: 1.95,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 40 * scale),
                        NewsBookmarkButton(
                          isBookmarked: _isBookmarked,
                          onTap: () {
                            setState(() {
                              _isBookmarked = !_isBookmarked;
                            });
                          },
                          scale: scale,
                          primaryColor: primaryColor,
                        ),
                        SizedBox(height: 30 * scale),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
