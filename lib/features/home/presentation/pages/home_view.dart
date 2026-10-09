// lib/features/home/presentation/pages/home_view.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shakwa_app/features/complaints/presentation/pages/add_complaint_view.dart';
import 'package:shakwa_app/features/complaints/presentation/pages/complaints_list_page.dart';
import 'package:shakwa_app/features/news/presentation/pages/news_view.dart';
import 'package:shakwa_app/features/notifications/presentation/pages/notifications_page.dart';
import 'package:shakwa_app/features/profile/presentation/pages/profile_view.dart';
import 'package:shakwa_app/features/track_complain/presentation/pages/track_complaint_page.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // قائمة الواجهات داخل دالة build لتمرير الـ context الشغال بشكل صحيح
    final List<Widget> pages = [
      _buildHomeContent(context), // Index 0: الرئيسية
      const ComplaintsListPage(), // Index 1: الشكاوي
      const NewsView(), // Index 2: الأخبار
      const NotificationsPage(), // Index 3: الإشعارات
      const ProfileView(), // Index 4: الحساب
    ];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),

        // عرض الصفحة المختارة
        body: IndexedStack(index: _currentIndex, children: pages),

        // الشريط السفلي للتنقل
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: Color(0xFFF2F4F4),
            border: Border(top: BorderSide(color: Color(0xFFE0E0E0), width: 1)),
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: const Color(0xFFF2F4F4),
            selectedItemColor: const Color(0xFF0C655E),
            unselectedItemColor: Colors.black87,
            selectedLabelStyle: GoogleFonts.tajawal(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            unselectedLabelStyle: GoogleFonts.tajawal(fontSize: 12),
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'رئيسية'),
              BottomNavigationBarItem(
                icon: Icon(Icons.article_outlined),
                label: 'الشكاوي',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.newspaper),
                label: 'الأخبار',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications_none),
                label: 'الإشعارات',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: 'الحساب',
              ),
            ],
          ),
        ),
      ),
    );
  }

  // محتوى الصفحة الرئيسية الأساسية (تم إزالة Scaffold الداخلي لتفادي التعارض)
  Widget _buildHomeContent(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double scale = screenWidth / 430.0;

    return Column(
      children: [
        // --- Header / AppBar للرئيسية ---
        Container(
          height: 100 * scale,
          color: const Color(0xFF0C655E),
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Stack(
            children: [
              Positioned(
                left: 16 * scale,
                top: 8 * scale,
                bottom: 8 * scale,
                width: 81 * scale,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: 81 * scale,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => Icon(
                          Icons.shield,
                          color: const Color(0xFFD4AF37),
                          size: 30 * scale,
                        ),
                      ),
                    ),
                    SizedBox(height: 2 * scale),
                    Text(
                      'شكوى',
                      style: GoogleFonts.tajawal(
                        fontSize: 11 * scale,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        height: 1.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // --- محتوى باقي عناصر الصفحة الرئيسية ---
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 35 * scale,
                vertical: 12 * scale,
              ),
              child: Column(
                children: [
                  SizedBox(height: 15 * scale),

                  // 1. بطاقة "منصة الشكاوي الحكومية"
                  Container(
                    width: 360 * scale,
                    height: 150 * scale,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20 * scale),
                      border: Border.all(
                        color: const Color(0xFF0C655E),
                        width: 1.2,
                      ),
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF0C655E),
                          Color(0xFF1E6F67),
                          Color(0xFF388E85),
                        ],
                        begin: Alignment.bottomRight,
                        end: Alignment.topLeft,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x40000000),
                          blurRadius: 4,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'منصة الشكاوي الحكومية',
                          style: GoogleFonts.tajawal(
                            fontSize: 21 * scale,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8 * scale),
                        Text(
                          'تقديم ومتابعة الشكاوي بسهولة وشفافية',
                          style: GoogleFonts.tajawal(
                            fontSize: 13 * scale,
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withOpacity(0.95),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 25 * scale),

                  // 2. زر "تقديم شكوى جديدة"
                  Container(
                    width: 360 * scale,
                    height: 50 * scale,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12 * scale),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x40000000),
                          blurRadius: 4,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddComplaintView(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0C655E),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12 * scale),
                        ),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'تقديم شكوى جديدة',
                            style: GoogleFonts.tajawal(
                              fontSize: 16 * scale,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 12 * scale),
                          Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 24 * scale,
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 25 * scale),

                  // 3. المربعات الأربعة للخدمات
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _buildServiceCard(
                              title: 'متابعة الشكوى',
                              icon: Icons.history,
                              scale: scale,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const TrackComplaintPage(),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(width: 16 * scale),
                          Expanded(
                            child: _buildServiceCard(
                              title: 'الشكاوي',
                              icon: Icons.article_outlined,
                              scale: scale,
                              onTap: () {},
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16 * scale),
                      Row(
                        children: [
                          Expanded(
                            child: _buildServiceCard(
                              title: 'الدعم',
                              icon: Icons.settings_suggest_outlined,
                              scale: scale,
                              onTap: () {},
                            ),
                          ),
                          SizedBox(width: 16 * scale),
                          Expanded(
                            child: _buildServiceCard(
                              title: 'الجهات الحكومية',
                              icon: Icons.account_balance_outlined,
                              scale: scale,
                              onTap: () {},
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 25 * scale),

                  // 4. بطاقات الإحصائيات
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          title: 'تم الحل',
                          value: '72',
                          color: const Color(0xFF4CAF50),
                          scale: scale,
                        ),
                      ),
                      SizedBox(width: 12 * scale),
                      Expanded(
                        child: _buildStatCard(
                          title: 'قيد التنفيذ',
                          value: '09',
                          color: const Color(0xFF64B5F6),
                          scale: scale,
                        ),
                      ),
                      SizedBox(width: 12 * scale),
                      Expanded(
                        child: _buildStatCard(
                          title: 'قيد المعالجة',
                          value: '14',
                          color: const Color(0xFFFFD54F),
                          scale: scale,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15 * scale),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // كرت الخدمة
  Widget _buildServiceCard({
    required String title,
    required IconData icon,
    required double scale,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16 * scale),
      child: Container(
        height: 110 * scale,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16 * scale),
          border: Border.all(color: const Color(0xFF1E1E1E), width: 1),
          boxShadow: const [
            BoxShadow(
              color: Color(0x33000000),
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30 * scale, color: const Color(0xFF0C655E)),
            SizedBox(height: 10 * scale),
            Text(
              title,
              style: GoogleFonts.tajawal(
                fontSize: 14 * scale,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF000000),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // كرت الإحصائيات
  Widget _buildStatCard({
    required String title,
    required String value,
    required Color color,
    required double scale,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 12 * scale,
        horizontal: 8 * scale,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14 * scale),
        border: Border.all(color: const Color(0xFFD0D0D0), width: 1),
        boxShadow: const [
          BoxShadow(
            color: Color(0x26000000),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: GoogleFonts.tajawal(
              fontSize: 12 * scale,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF222222),
            ),
          ),
          SizedBox(height: 8 * scale),
          Text(
            value,
            style: GoogleFonts.tajawal(
              fontSize: 22 * scale,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: 6 * scale),
          Container(
            height: 3.5 * scale,
            width: double.infinity,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2 * scale),
            ),
          ),
        ],
      ),
    );
  }
}
