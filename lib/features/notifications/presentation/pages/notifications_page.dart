import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shakwa_app/features/notifications/data/datasources/notification_remote_data_source.dart';
import 'package:shakwa_app/features/notifications/data/repositories/notification_repository_impl.dart';
import 'package:shakwa_app/features/notifications/domain/usecases/get_notifications_usecase.dart';
import 'package:shakwa_app/features/notifications/presentation/cubit/notification_cubit.dart';
import 'package:shakwa_app/features/notifications/presentation/cubit/notification_state.dart';
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

    return BlocProvider(
      create: (context) => NotificationCubit(
        getNotificationsUseCase: GetNotificationsUseCase(
          NotificationRepositoryImpl(
            remoteDataSource: NotificationRemoteDataSourceImpl(
              dio: Dio(
                BaseOptions(
                  baseUrl:
                      'https://palegoldenrod-rabbit-772161.hostingersite.com/',
                  connectTimeout: const Duration(seconds: 30),
                  receiveTimeout: const Duration(seconds: 30),
                  headers: {
                    'User-Agent': 'Mozilla/5.0',
                    'Accept': 'application/json',
                  },
                ),
              ),
            ),
          ),
        ),
      )..fetchNotifications(), // استدعاء الدالة لجلب البيانات مباشرة عند إنشاء الكيوبت
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: const Color(0xFFF7F8FA),
          appBar: NotificationsAppBar(
            scale: scale,
            onMarkAllAsRead: () {
              // استدعاء دالة تمييز الكل كمقروء عبر الكيوبت
              context.read<NotificationCubit>().markAllAsReadLocally();
            },
          ),
          body: Column(
            children: [
              // شريط الفلاتر (Filter Chips) - يبقى كما هو بتصميمك الأنيق
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
                        onTap: () =>
                            setState(() => _selectedFilter = 'الشكاوي'),
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
                        onTap: () =>
                            setState(() => _selectedFilter = 'الاخبار'),
                        scale: scale,
                        primaryColor: primaryColor,
                      ),
                    ],
                  ),
                ),
              ),

              // جسم الصفحة المرتبط بالـ Cubit لجلب وعرض البيانات
              Expanded(
                child: BlocBuilder<NotificationCubit, NotificationState>(
                  builder: (context, state) {
                    // 1. حالة التحميل
                    if (state is NotificationLoading) {
                      return const Center(
                        child: CircularProgressIndicator(color: primaryColor),
                      );
                    }
                    // 2. حالة الخطأ
                    else if (state is NotificationError) {
                      return Center(
                        child: Text(
                          'حدث خطأ: ${state.message}',
                          style: GoogleFonts.tajawal(
                            color: Colors.red,
                            fontSize: 14 * scale,
                          ),
                        ),
                      );
                    }
                    // 3. حالة النجاح ووجود بيانات
                    else if (state is NotificationLoaded) {
                      // تطبيق الفلترة بناءً على التبويب المختار
                      final filteredNotifications = _selectedFilter == 'الكل'
                          ? state.notifications
                          : state.notifications
                                .where((n) => n.type == _selectedFilter)
                                .toList();

                      if (filteredNotifications.isEmpty) {
                        return Center(
                          child: Text(
                            'لا توجد إشعارات حالياً',
                            style: GoogleFonts.tajawal(
                              color: Colors.grey,
                              fontSize: 14 * scale,
                            ),
                          ),
                        );
                      }

                      return ListView.builder(
                        padding: EdgeInsets.all(16 * scale),
                        itemCount: filteredNotifications.length,
                        itemBuilder: (context, index) {
                          final item = filteredNotifications[index];

                          return AnimatedBuilder(
                            animation: _animationController,
                            builder: (context, child) {
                              final double delay = index * 0.1;
                              final double val =
                                  ((_animationController.value - delay) /
                                          (1.0 - delay))
                                      .clamp(0.0, 1.0);

                              return Transform.translate(
                                offset: Offset(0, 25 * (1 - val)),
                                child: Opacity(opacity: val, child: child),
                              );
                            },
                            child: NotificationCard(
                              // ملاحظة: بما أننا نستخدم Entity الآن، نقوم بتمرير الحقول للـ Card
                              item: {
                                'title': item.title,
                                'time': item.time,
                                'type': item.type,
                                'isRead': item.isRead,
                                'icon': item.icon,
                              },
                              scale: scale,
                              primaryColor: primaryColor,
                            ),
                          );
                        },
                      );
                    }

                    // الحالة الابتدائية (Initial)
                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
