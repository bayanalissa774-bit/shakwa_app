import 'package:dio/dio.dart';
import 'package:shakwa_app/features/notifications/data/models/notification_model.dart';

abstract class NotificationRemoteDataSource {
  Future<List<NotificationModel>> getNotifications();
  Future<void> markAllAsRead();
}

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final Dio dio;

  NotificationRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<NotificationModel>> getNotifications() async {
    // سنقوم بإرسال طلب لجلب الإشعارات من السيرفر
    // (استبدلي الرابط بالـ Endpoint الخاص بالإشعارات في سيرفركم)
    final response = await dio.get('/api/v1/notifications/get.php');

    // تحويل البيانات القادمة إلى قائمة من NotificationModel
    final List data = response.data['notifications'] ?? [];
    return data.map((json) => NotificationModel.fromJson(json)).toList();
  }

  @override
  Future<void> markAllAsRead() async {
    // طلب للسيرفر لتحديث حالة كل الإشعارات لتصبح مقروءة
    await dio.post('/notifications/mark-read');
  }
}
