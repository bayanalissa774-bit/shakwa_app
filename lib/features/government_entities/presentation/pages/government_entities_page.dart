import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shakwa_app/features/home/presentation/pages/home_view.dart';

import '../../../../main.dart'; // للعودة لصفحة الـ HomeView عند الضغط على زر الرجوع
import '../widgets/entity_card.dart';

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
            // اليسار: الشعار والنسر مع كلمة شكوى
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //       // أيقونة الإشعارات في اليمين
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
                // العودة المباشرة للرئيسية ومسح الصفحات السابقة
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeView(),
                  ), // استبدلي HomeView بالاسم الصحيح لدتيكِ
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
            // صندوق البحث العلوي مع زر الـ X التفاعلي وأيقونة العدسة
            Container(
              margin: EdgeInsets.all(20 * scale),
              padding: EdgeInsets.symmetric(horizontal: 16 * scale),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12 * scale),
                border: Border.all(color: Colors.grey.shade300),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  TextField(
                    controller: _searchController,
                    textAlign: TextAlign.right,
                    onChanged: (value) => setState(() {}),
                    style: GoogleFonts.tajawal(
                      fontSize: 14 * scale,
                      color: const Color(0xFF1E1E1E),
                    ),
                    decoration: InputDecoration(
                      hintText: 'البحث عن جهة حكومية....',
                      hintStyle: GoogleFonts.tajawal(
                        fontSize: 13 * scale,
                        color: Colors.grey.shade400,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey.shade400,
                        size: 22 * scale,
                      ),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: Icon(
                                Icons.close,
                                color: Colors.grey.shade600,
                                size: 18 * scale,
                              ),
                              onPressed: () {
                                setState(() {
                                  _searchController.clear();
                                });
                              },
                            )
                          : null,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 14 * scale,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 48 * scale,
                    child: ElevatedButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10 * scale),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'بحث',
                        style: GoogleFonts.tajawal(
                          fontSize: 15 * scale,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12 * scale),
                ],
              ),
            ),

            // حاوية الصفحات المتحركة (PageView Carousel) للكرتات والنقاط التفاعلية
            SizedBox(
              height: 380 * scale,
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: [
                  // الصفحة الأولى: كروت وزارة الصحة المتطابقة تماماً مع الفيجما
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20 * scale),
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16 * scale,
                      mainAxisSpacing: 16 * scale,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: const [
                        EntityCard(
                          title: 'وزارة الصحة',
                          subtitle: 'الرعاية الصحية',
                        ),
                        EntityCard(
                          title: 'وزارة الداخلية',
                          subtitle: 'خدمات المواطنين',
                        ),
                        EntityCard(
                          title: 'وزارة التربية',
                          subtitle: 'التعليم الأساسي',
                        ),
                        EntityCard(
                          title: 'وزارة العدل',
                          subtitle: 'الخدمات العدلية',
                        ),
                      ],
                    ),
                  ),

                  // الصفحة الثانية: بيانات وهمية مختلفة (مثل وزارة التربية) لاختبار السحب
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20 * scale),
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16 * scale,
                      mainAxisSpacing: 16 * scale,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: const [
                        EntityCard(
                          title: 'وزارة التربية',
                          subtitle: 'التعليم الأساسي',
                        ),
                        EntityCard(
                          title: 'وزارة التعليم',
                          subtitle: 'التعليم العالي',
                        ),
                        EntityCard(
                          title: 'وزارة الداخلية',
                          subtitle: 'خدمات المواطنين',
                        ),
                        EntityCard(
                          title: 'وزارة العدل',
                          subtitle: 'الخدمات العدلية',
                        ),
                      ],
                    ),
                  ),

                  // الصفحة الثالثة: صفحة إضافية لتفعيل وتجربة حركة الـ PageView بثلاث نقاط
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20 * scale),
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16 * scale,
                      mainAxisSpacing: 16 * scale,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: const [
                        EntityCard(
                          title: 'وزارة المالية',
                          subtitle: 'الضرائب والرسوم',
                        ),
                        EntityCard(
                          title: 'وزارة النقل',
                          subtitle: 'النقل البري والبحري',
                        ),
                        EntityCard(
                          title: 'وزارة الإدارة',
                          subtitle: 'شؤون البلديات',
                        ),
                        EntityCard(
                          title: 'وزارة الاتصالات',
                          subtitle: 'التحول الرقمي',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16 * scale),

            // نقاط الـ Smooth Page Indicator التفاعلية السفلية تماماً كالتصميم
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
