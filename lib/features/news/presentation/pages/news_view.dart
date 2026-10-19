import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shakwa_app/features/home/presentation/widgets/favorites_sheet.dart';
import 'package:shakwa_app/features/news/presentation/cubit/news_cubit.dart';
import 'package:shakwa_app/features/news/presentation/widgets/news_view/news_banner_slider.dart';
import 'package:shakwa_app/features/news/presentation/widgets/news_view/news_categories_bar.dart';
import 'package:shakwa_app/features/news/presentation/widgets/news_view/news_list_section.dart';

// استوردنا طبقات الـ Data و Domain لإنشاء الـ Cubit هنا بسهولة
import 'package:dio/dio.dart';

import '../../data/datasources/news_remote_data_source.dart';
import '../../data/repositories/news_repository_impl.dart';
import '../../domain/usecases/get_news_usecase.dart';

class NewsView extends StatelessWidget {
  const NewsView({super.key});

  @override
  Widget build(BuildContext context) {
    // ننشئ الـ Cubit ونزوده للشاشة مباشرةً
    return BlocProvider(
      create: (context) {
        final dio = Dio();
        final remoteDataSource = NewsRemoteDataSourceImpl(dio);
        final repository = NewsRepositoryImpl(remoteDataSource);
        final getNewsUseCase = GetNewsUseCase(repository);
        return NewsCubit(getNewsUseCase: getNewsUseCase);
      },
      child: const _NewsViewContent(),
    );
  }
}

class _NewsViewContent extends StatefulWidget {
  const _NewsViewContent();

  @override
  State<_NewsViewContent> createState() => _NewsViewContentState();
}

class _NewsViewContentState extends State<_NewsViewContent> {
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

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // جلب الأخبار فور استدعاء الصفحة
    context.read<NewsCubit>().fetchNews();
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

              // السلايدر العلوي
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

              // أزرار التصنيفات
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

              // قائمة الأخبار السفلية
            NewsListSection(
  scale: scale, 
  primaryColor: primaryColor,
  selectedCategory: _categories[_selectedCategoryIndex], // 👈 إرسال التصنيف المختار
),
              SizedBox(height: 20 * scale),
            ],
          ),
        ),
      ),
    );
  }
}
