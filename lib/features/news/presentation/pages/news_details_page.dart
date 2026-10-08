// lib/features/home/presentation/pages/news_details_page.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          toolbarHeight: 75 * scale,
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16 * scale),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  borderRadius: BorderRadius.circular(20 * scale),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8 * scale,
                      vertical: 4 * scale,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                          size: 18 * scale,
                        ),
                        SizedBox(width: 6 * scale),
                        Text(
                          'رجوع',
                          style: GoogleFonts.tajawal(
                            fontSize: 15 * scale,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  'تفاصيل الخبر',
                  style: GoogleFonts.tajawal(
                    fontSize: 18 * scale,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(20 * scale),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8 * scale,
                      vertical: 4 * scale,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'مزيد',
                          style: GoogleFonts.tajawal(
                            fontSize: 15 * scale,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 4 * scale),
                        const Icon(
                          Icons.more_vert,
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          titleSpacing: 0,
        ),
        // === هنا تم إضافة الـ ClipRRect مباشرة تحت الـ body ===
        body: ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(45 * scale)),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // --- هيدر الصورة ---
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

              // --- الحاوية البيضاء ذات الحواف الناعمة أثناء السكرول ---
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
                            _buildCategoryChip(
                              'الأخبار المحلية',
                              primaryColor,
                              scale,
                            ),
                            SizedBox(width: 10 * scale),
                            _buildCategoryChip('هام', accentRed, scale),
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
                        Center(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _isBookmarked = !_isBookmarked;
                              });
                            },
                            borderRadius: BorderRadius.circular(20 * scale),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              padding: EdgeInsets.symmetric(
                                horizontal: 26 * scale,
                                vertical: 12 * scale,
                              ),
                              decoration: BoxDecoration(
                                color: _isBookmarked
                                    ? const Color(0xFFFFF8E1)
                                    : primaryColor.withOpacity(0.06),
                                borderRadius: BorderRadius.circular(20 * scale),
                                border: Border.all(
                                  color: _isBookmarked
                                      ? const Color(0xFFFFB300)
                                      : primaryColor.withOpacity(0.2),
                                  width: 1.5,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    _isBookmarked
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: _isBookmarked
                                        ? const Color(0xFFFFA000)
                                        : primaryColor,
                                    size: 22 * scale,
                                  ),
                                  SizedBox(width: 10 * scale),
                                  Text(
                                    _isBookmarked
                                        ? 'تمت الإضافة للمفضلة'
                                        : 'إضافة للمفضلة',
                                    style: GoogleFonts.tajawal(
                                      fontSize: 15 * scale,
                                      fontWeight: FontWeight.bold,
                                      color: _isBookmarked
                                          ? const Color(0xFF8D6E63)
                                          : primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
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

  Widget _buildCategoryChip(String label, Color color, double scale) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 14 * scale,
        vertical: 6 * scale,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20 * scale),
        border: Border.all(color: color.withOpacity(0.2), width: 1),
      ),
      child: Text(
        label,
        style: GoogleFonts.tajawal(
          fontSize: 12 * scale,
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
