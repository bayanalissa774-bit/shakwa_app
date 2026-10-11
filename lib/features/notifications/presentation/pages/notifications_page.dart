// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:shakwa_app/features/notifications/presentation/widgets/notifications_app/notification_card.dart';
import 'package:shakwa_app/features/notifications/presentation/widgets/notifications_app/notification_filter_chip.dart';
import 'package:shakwa_app/features/notifications/presentation/widgets/notifications_app/notifications_app_bar.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  String _selectedFilter = 'الكل';

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

    const Color primaryColor = Color(0xFF0C655E);
    const Color goldColor = Color(0xFFD4AF37);

    final filteredNotifications = _selectedFilter == 'الكل'
        ? _notifications
        : _notifications.where((n) => n['type'] == _selectedFilter).toList();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F8FA),
        appBar: NotificationsAppBar(
          scale: scale,
          onMarkAllAsRead: () {
            setState(() {
              for (var n in _notifications) {
                n['isRead'] = true;
              }
            });
          },
        ),
        body: Column(
          children: [
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
                    NotificationFilterChip(
                      label: 'الكل',
                      isSelected: _selectedFilter == 'الكل',
                      onTap: () => setState(() => _selectedFilter = 'الكل'),
                      scale: scale,
                      primaryColor: primaryColor,
                    ),
                    SizedBox(width: 8 * scale),
                    NotificationFilterChip(
                      label: 'الشكاوي',
                      isSelected: _selectedFilter == 'الشكاوي',
                      onTap: () => setState(() => _selectedFilter = 'الشكاوي'),
                      scale: scale,
                      primaryColor: primaryColor,
                    ),
                    SizedBox(width: 8 * scale),
                    NotificationFilterChip(
                      label: 'الردود',
                      isSelected: _selectedFilter == 'الردود',
                      onTap: () => setState(() => _selectedFilter = 'الردود'),
                      scale: scale,
                      primaryColor: primaryColor,
                    ),
                    SizedBox(width: 8 * scale),
                    NotificationFilterChip(
                      label: 'الاخبار',
                      isSelected: _selectedFilter == 'الاخبار',
                      onTap: () => setState(() => _selectedFilter = 'الاخبار'),
                      scale: scale,
                      primaryColor: primaryColor,
                    ),
                  ],
                ),
              ),
            ),
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
                    child: NotificationCard(
                      item: item,
                      scale: scale,
                      primaryColor: primaryColor,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
