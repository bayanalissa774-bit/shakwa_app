// lib/features/notifications/presentation/pages/notifications_page.dart

// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  String _selectedFilter = 'الكل';

  // قائمة الإشعارات مطابقة تماماً لنصوص الفيجما
  final List<Map<String, dynamic>> _notifications = [
    {
      'title': 'تم استقبال شكوى رقم 123',
      'time': 'منذ دقيقة',
      'type': 'الشكاوي',
      'isRead': false,
      'icon': Icons.campaign_rounded,
    },
    {
      'title': 'رد جديد على طلبك',
      'time': 'منذ 11 دقيقة',
      'type': 'الردود',
      'isRead': true,
      'icon': Icons.description_rounded,
    },
    {
      'title': 'تم استقبال شكوى رقم 123',
      'time': 'منذ دقيقة',
      'type': 'الشكاوي',
      'isRead': false,
      'icon': Icons.campaign_rounded,
    },
    {
      'title': 'تم استقبال شكوى رقم 123',
      'time': 'منذ دقيقة',
      'type': 'الشكاوي',
      'isRead': false,
      'icon': Icons.campaign_rounded,
    },
    {
      'title': 'اعلان فتح تقديم للمشاريع',
      'time': 'اليوم',
      'type': 'الاخبار',
      'isRead': true,
      'icon': Icons.flag_rounded,
    },
    {
      'title': 'تم استقبال شكوى رقم 123',
      'time': 'منذ دقيقة',
      'type': 'الشكاوي',
      'isRead': false,
      'icon': Icons.campaign_rounded,
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double scale = screenWidth / 430.0;

    const Color primaryColor = Color(0xFF0C655E); // الكحلي الداكن الرسمي
    const Color goldColor = Color(0xFFD4AF37); // الذهبي الفاخر

    // تصفية الإشعارات بناءً على الفلتر المختار
    final filteredNotifications = _selectedFilter == 'الكل'
        ? _notifications
        : _notifications.where((n) => n['type'] == _selectedFilter).toList();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F8FA),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(75 * scale),
          child: AppBar(
            backgroundColor: const Color(0xFF0C655E),
            elevation: 0,
            automaticallyImplyLeading: false,
            flexibleSpace: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16 * scale),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // اليمين: زر رجوع والسهم

                    //       // 3. زر تمييز الكل كـ مقروء في اليسار
                    InkWell(
                      onTap: () {
                        setState(() {
                          for (var n in _notifications) {
                            n['isRead'] = true;
                          }
                        });
                      },
                      child: Row(
                        children: [
                          Text(
                            'تمييز الكل كـ مقروء',
                            style: GoogleFonts.tajawal(
                              fontSize: 11 * scale,
                              color: Colors.white.withValues(alpha: 0.9),
                            ),
                          ),
                          SizedBox(width: 4 * scale),
                          Icon(
                            Icons.done_all,
                            color: Colors.white,
                            size: 16 * scale,
                          ),
                        ],
                      ),
                    ),
                    // الوسط: عنوان الشاشة
                    Text(
                      "الإشعارات",
                      style: GoogleFonts.tajawal(
                        fontSize: 17 * scale,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    // اليسار: الشعار والنسر مع كلمة شكوى
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/logo.png',
                          height: 44 * scale,
                          width: 80 * scale,
                          errorBuilder: (context, error, stackTrace) => Icon(
                            Icons.shield,
                            color: const Color(0xFFD4AF37),
                            size: 37 * scale,
                          ),
                        ),
                        SizedBox(height: 3 * scale),
                        Text(
                          'شكوى',
                          style: GoogleFonts.tajawal(
                            fontSize: 10 * scale,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        body: Column(
          children: [
            // 2. شريط الفلاتر الأفقية تحت الـ AppBar مباشرة
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                vertical: 14 * scale,
                horizontal: 16 * scale,
              ),
              color: Colors.white,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: [
                    _buildFilterChip('الكل', scale, primaryColor),
                    SizedBox(width: 8 * scale),
                    _buildFilterChip('الشكاوي', scale, primaryColor),
                    SizedBox(width: 8 * scale),
                    _buildFilterChip('الردود', scale, primaryColor),
                    SizedBox(width: 8 * scale),
                    _buildFilterChip('الاخبار', scale, primaryColor),
                  ],
                ),
              ),
            ),

            // 3. قائمة الإشعارات مع حركات ظهور متسلسلة (Fade & Slide Animation)
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(16 * scale),
                itemCount: filteredNotifications.length,
                itemBuilder: (context, index) {
                  final item = filteredNotifications[index];

                  return AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      final double delay = index * 0.1;
                      final double val =
                          ((_animationController.value - delay) / (1.0 - delay))
                              .clamp(0.0, 1.0);

                      return Transform.translate(
                        offset: Offset(0, 25 * (1 - val)),
                        child: Opacity(opacity: val, child: child),
                      );
                    },
                    child: _buildNotificationCard(item, scale, primaryColor),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ودجت أزرار الفلترة العلوية
  Widget _buildFilterChip(String label, double scale, Color primaryColor) {
    final bool isSelected = _selectedFilter == label;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedFilter = label;
        });
      },
      borderRadius: BorderRadius.circular(24 * scale),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20 * scale,
          vertical: 8 * scale,
        ),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(24 * scale),
          border: Border.all(
            color: isSelected ? primaryColor : Colors.grey.shade300,
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.tajawal(
            fontSize: 13 * scale,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : Colors.grey.shade700,
          ),
        ),
      ),
    );
  }

  // ودجت كرت الإشعار الواحد المطابق تماماً للفيجما مع نقطة عدم القراءة والأيقونة
  Widget _buildNotificationCard(
    Map<String, dynamic> item,
    double scale,
    Color primaryColor,
  ) {
    final bool isRead = item['isRead'];

    return Container(
      margin: EdgeInsets.only(bottom: 14 * scale),
      padding: EdgeInsets.symmetric(
        horizontal: 16 * scale,
        vertical: 14 * scale,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(
          color: isRead
              ? Colors.grey.shade200
              : primaryColor.withValues(alpha: 0.4),
          width: isRead ? 1 : 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // نقطة الإشعار غير المقروء (أخضر بارز كما في الفيجما للغير مقروء)
          if (!isRead)
            Container(
              width: 8 * scale,
              height: 8 * scale,
              margin: EdgeInsets.only(left: 12 * scale),
              decoration: const BoxDecoration(
                color: Color(0xFF00C853),
                shape: BoxShape.circle,
              ),
            )
          else
            SizedBox(width: 20 * scale),

          // النصوص (العنوان ووقت الإشعار)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['title'],
                  style: GoogleFonts.tajawal(
                    fontSize: 15 * scale,
                    fontWeight: isRead ? FontWeight.normal : FontWeight.bold,
                    color: const Color(0xFF1E1E1E),
                  ),
                ),
                SizedBox(height: 4 * scale),
                Text(
                  item['time'],
                  style: GoogleFonts.tajawal(
                    fontSize: 12 * scale,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),

          // أيقونة الإشعار الدائرية المميزة في الجهة اليسار
          Container(
            padding: EdgeInsets.all(10 * scale),
            decoration: BoxDecoration(
              color: primaryColor.withValues(alpha: 0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(item['icon'], color: primaryColor, size: 22 * scale),
          ),
        ],
      ),
    );
  }
}
