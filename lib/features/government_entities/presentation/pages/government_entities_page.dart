import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shakwa_app/features/government_entities/presentation/widgets/government_entities_slider.dart';
import 'package:shakwa_app/features/government_entities/presentation/widgets/government_search_box.dart';
import 'package:shakwa_app/features/home/presentation/pages/home_view.dart';

class GovernmentEntitiesPage extends StatefulWidget {
  const GovernmentEntitiesPage({super.key});

  @override
  State<GovernmentEntitiesPage> createState() => _GovernmentEntitiesPageState();
}

class _GovernmentEntitiesPageState extends State<GovernmentEntitiesPage> {
  final TextEditingController _searchController = TextEditingController();
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _searchController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double scale = MediaQuery.of(context).size.width / 430.0;
    const Color primaryColor = Color(0xFF0C655E);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: 70 * scale,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0 * scale),
                  child: const Icon(
                    Icons.notifications_none_rounded,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Text(
              'الجهات الحكومية',
              style: GoogleFonts.tajawal(
                fontSize: 18 * scale,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeView()),
                  (route) => false,
                );
              },
              child: Row(
                children: [
                  Text(
                    'رجوع',
                    style: GoogleFonts.tajawal(
                      fontSize: 15 * scale,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 4 * scale),
                  const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            GovernmentSearchBox(
              searchController: _searchController,
              scale: scale,
              primaryColor: primaryColor,
              onChanged: (value) => setState(() {}),
              onClear: () => setState(() => _searchController.clear()),
              onSearchPressed: () => FocusScope.of(context).unfocus(),
            ),
            GovernmentEntitiesSlider(
              pageController: _pageController,
              onPageChanged: (index) => setState(() => _currentPage = index),
              scale: scale,
            ),
            SizedBox(height: 16 * scale),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                bool isSelected = _currentPage == index;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: 4 * scale),
                  height: 8 * scale,
                  width: isSelected ? 24 * scale : 8 * scale,
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor : Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(4 * scale),
                  ),
                );
              }),
            ),
            SizedBox(height: 30 * scale),
          ],
        ),
      ),
    );
  }
}
