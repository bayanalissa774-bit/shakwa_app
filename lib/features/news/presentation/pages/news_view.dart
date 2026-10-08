// lib/features/home/presentation/pages/news_view.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shakwa_app/features/news/presentation/pages/news_details_page.dart';
import 'package:shakwa_app/features/home/presentation/widgets/favorites_sheet.dart';

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
          // اليمين: زر الإشعارات (الجرس)
          leading: IconButton(
            icon: Icon(
              Icons.notifications_none,
              color: Colors.white,
              size: 26 * scale,
            ),
            onPressed: () {},
          ),
          // الوسط: عنوان الشاشة متوسع بدقة
          title: Text(
            'الأخبار',
            style: GoogleFonts.tajawal(
              color: Colors.white,
              fontSize: 18 * scale,
              fontWeight: FontWeight.bold,
            ),
          ),
          // اليسار: أزرار المفضلة والبحث بمسافات نظامية
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

              // 1. السلايدر العلوي بأبعاد مضبوطة
              SizedBox(
                height: 290 * scale,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _bannerImages.length,
                  onPageChanged: (index) {
                    setState(() {
                      _bannerIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final isSelected = index == _bannerIndex;
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
                          _bannerImages[index],
                          fit: BoxFit.fill,
                          width: double.infinity,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
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

              // 2. مؤشر النقاط لصفحات السلايدر
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _bannerImages.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _bannerIndex == index ? 22 * scale : 8 * scale,
                    height: 8 * scale,
                    decoration: BoxDecoration(
                      color: _bannerIndex == index
                          ? primaryColor
                          : const Color(0xFFBDBDBD),
                      borderRadius: BorderRadius.circular(4 * scale),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20 * scale),

              // 3. أزرار التصنيفات
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20 * scale),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(_categories.length, (index) {
                    final isSelected = _selectedCategoryIndex == index;
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _selectedCategoryIndex = index;
                        });
                      },
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
                          _categories[index],
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
              ),

              SizedBox(height: 20 * scale),

              // 4. قائمة الأخبار السفلية
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20 * scale),
                itemCount: _newsItems.length,
                itemBuilder: (context, index) {
                  final item = _newsItems[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewsDetailsPage(
                            title: item['title'],
                            imagePath: item['image'],
                            date: item['time'],
                          ),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(16 * scale),
                    child: Container(
                      margin: EdgeInsets.only(bottom: 16 * scale),
                      padding: EdgeInsets.all(12 * scale),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16 * scale),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x11000000),
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          // صورة الخبر (على اليمين)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12 * scale),
                            child: Image.asset(
                              item['image']!,
                              width: 80 * scale,
                              height: 80 * scale,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                    width: 80 * scale,
                                    height: 80 * scale,
                                    color: Colors.grey[300],
                                    child: const Icon(
                                      Icons.image,
                                      color: Colors.grey,
                                    ),
                                  ),
                            ),
                          ),
                          SizedBox(width: 12 * scale),

                          // تفاصيل الخبر والنص (على اليسار)
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // التاج
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 14 * scale,
                                    vertical: 3 * scale,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFCDCDC),
                                    borderRadius: BorderRadius.circular(
                                      12 * scale,
                                    ),
                                  ),
                                  child: Text(
                                    item['tag']!,
                                    style: GoogleFonts.tajawal(
                                      fontSize: 11 * scale,
                                      color: const Color(0xFFD32F2F),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8 * scale),
                                // العنوان
                                Text(
                                  item['title']!,
                                  style: GoogleFonts.tajawal(
                                    fontSize: 13 * scale,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                // الوصف
                                Text(
                                  item['subtitle']!,
                                  style: GoogleFonts.tajawal(
                                    fontSize: 11 * scale,
                                    color: Colors.grey[600],
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 8 * scale),
                                // الوقت
                                Text(
                                  item['time']!,
                                  style: GoogleFonts.tajawal(
                                    fontSize: 10 * scale,
                                    color: Colors.grey[400],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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
