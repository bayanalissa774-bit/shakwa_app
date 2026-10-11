import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shakwa_app/features/home/presentation/widgets/favorites_sheet.dart';
import 'package:shakwa_app/features/news/presentation/pages/news_details_page.dart';
import 'package:shakwa_app/features/news/presentation/widgets/news_view/news_banner_slider.dart';
import 'package:shakwa_app/features/news/presentation/widgets/news_view/news_card_item.dart';
import 'package:shakwa_app/features/news/presentation/widgets/news_view/news_categories_bar.dart';

class NewsView extends StatefulWidget {
  const NewsView({super.key});

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  int _selectedCategoryIndex = 0;
  int _bannerIndex = 1;
  final PageController _pageController = PageController(
    viewportFraction: 0.75,
    initialPage: 1,
  );

  final List<String> _categories = ['الكل', 'تنبيهات', 'خدمات', 'إنجازات'];

  final List<String> _bannerImages = [
    'assets/images/news_item_thumb (1).png',
    'assets/images/news_item_thumb (2).png',
    'assets/images/news_item_thumb (3).png',
  ];

  final List<Map<String, String>> _newsItems = [
    {
      'title': 'وزير الداخلية يدرس اجتماعا هاماً',
      'subtitle': 'مناقشة مستجدات الأمن الرقمي',
      'tag': 'هام',
      'time': 'منذ ساعة واحدة',
      'image': 'assets/images/news_item_thumb (1).png',
    },
    {
      'title': 'وزير الداخلية يدرس اجتماعا هاماً',
      'subtitle': 'مناقشة مستجدات الأمن الرقمي',
      'tag': 'هام',
      'time': 'منذ ساعة واحدة',
      'image': 'assets/images/news_item_thumb (2).png',
    },
    {
      'title': 'وزير الداخلية يدرس اجتماعا هاماً',
      'subtitle': 'مناقشة مستجدات الأمن الرقمي',
      'tag': 'هام',
      'time': 'منذ ساعة واحدة',
      'image': 'assets/images/news_item_thumb (3).png',
    },
    {
      'title': 'وزير الداخلية يدرس اجتماعا هاماً',
      'subtitle': 'مناقشة مستجدات الأمن الرقمي',
      'tag': 'هام',
      'time': 'منذ ساعة واحدة',
      'image': 'assets/images/news_item_thumb (4).png',
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double scale = screenWidth / 430.0;

    const Color primaryColor = Color(0xFF0C655E);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0,
          centerTitle: true,
          toolbarHeight: 75 * scale,
          leading: IconButton(
            icon: Icon(
              Icons.notifications_none,
              color: Colors.white,
              size: 26 * scale,
            ),
            onPressed: () {},
          ),
          title: Text(
            'الأخبار',
            style: GoogleFonts.tajawal(
              color: Colors.white,
              fontSize: 18 * scale,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.favorite_border,
                color: Colors.white,
                size: 24 * scale,
              ),
              onPressed: () {
                showFavoritesSheet(context, scale);
              },
            ),
            IconButton(
              icon: Icon(Icons.search, color: Colors.white, size: 26 * scale),
              onPressed: () {},
            ),
            SizedBox(width: 8 * scale),
          ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 16 * scale),

              // السلايدر العلوي المفصول
              NewsBannerSlider(
                pageController: _pageController,
                bannerImages: _bannerImages,
                bannerIndex: _bannerIndex,
                onPageChanged: (index) {
                  setState(() {
                    _bannerIndex = index;
                  });
                },
                scale: scale,
                primaryColor: primaryColor,
              ),

              SizedBox(height: 20 * scale),

              // أزرار التصنيفات المفصولة
              NewsCategoriesBar(
                categories: _categories,
                selectedCategoryIndex: _selectedCategoryIndex,
                onCategorySelected: (index) {
                  setState(() {
                    _selectedCategoryIndex = index;
                  });
                },
                scale: scale,
                primaryColor: primaryColor,
              ),

              SizedBox(height: 20 * scale),

              // قائمة الأخبار السفلية المفصولة
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20 * scale),
                itemCount: _newsItems.length,
                itemBuilder: (context, index) {
                  final item = _newsItems[index];
                  return NewsCardItem(
                    item: item,
                    scale: scale,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewsDetailsPage(
                            title: item['title']!,
                            imagePath: item['image']!,
                            date: item['time']!,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              SizedBox(height: 20 * scale),
            ],
          ),
        ),
      ),
    );
  }
}
