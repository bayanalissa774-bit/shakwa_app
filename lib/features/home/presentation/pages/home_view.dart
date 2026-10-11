// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shakwa_app/features/complaints/presentation/pages/add_complaint_page.dart';
import 'package:shakwa_app/features/complaints/presentation/pages/complaints_list_page.dart';
import 'package:shakwa_app/features/government_entities/presentation/pages/government_entities_page.dart';
import 'package:shakwa_app/features/home/presentation/widgets/favorites_sheet.dart';
import 'package:shakwa_app/features/home/presentation/widgets/home_view/home_banner_card.dart';
import 'package:shakwa_app/features/home/presentation/widgets/home_view/home_app_bar.dart';
import 'package:shakwa_app/features/home/presentation/widgets/home_view/service_card.dart';
import 'package:shakwa_app/features/home/presentation/widgets/home_view/stat_card.dart';
import 'package:shakwa_app/features/news/presentation/pages/news_view.dart';
import 'package:shakwa_app/features/notifications/presentation/pages/notifications_page.dart';
import 'package:shakwa_app/features/profile/presentation/pages/profile_view.dart';
import 'package:shakwa_app/features/support/presentation/pages/support_page.dart';
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
    final List<Widget> pages = [
      _buildHomeContent(context),
      const ComplaintsListPage(),
      const NewsView(),
      const NotificationsPage(),
      const ProfileView(),
    ];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        body: IndexedStack(index: _currentIndex, children: pages),
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

  Widget _buildHomeContent(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double scale = screenWidth / 430.0;

    return Column(
      children: [
        HomeAppBar(scale: scale),
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
                  HomeBannerCard(scale: scale),
                  SizedBox(height: 25 * scale),
                  Container(
                    width: 360 * scale,
                    height: 50 * scale,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12 * scale),
                      boxShadow: [
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
                            builder: (context) => const AddComplaintPage(),
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
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: ServiceCard(
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
                            child: ServiceCard(
                              title: 'الشكاوي',
                              icon: Icons.article_outlined,
                              scale: scale,
                              onTap: () {
                                setState(() {
                                  _currentIndex = 1;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16 * scale),
                      Row(
                        children: [
                          Expanded(
                            child: ServiceCard(
                              title: 'الدعم',
                              icon: Icons.settings_suggest_outlined,
                              scale: scale,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SupportPage(),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(width: 16 * scale),
                          Expanded(
                            child: ServiceCard(
                              title: 'الجهات الحكومية',
                              icon: Icons.account_balance_outlined,
                              scale: scale,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const GovernmentEntitiesPage(),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 25 * scale),
                  Row(
                    children: [
                      Expanded(
                        child: StatCard(
                          title: 'تم الحل',
                          value: '72',
                          color: const Color(0xFF4CAF50),
                          scale: scale,
                        ),
                      ),
                      SizedBox(width: 12 * scale),
                      Expanded(
                        child: StatCard(
                          title: 'قيد التنفيذ',
                          value: '09',
                          color: const Color(0xFF64B5F6),
                          scale: scale,
                        ),
                      ),
                      SizedBox(width: 12 * scale),
                      Expanded(
                        child: StatCard(
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
}
