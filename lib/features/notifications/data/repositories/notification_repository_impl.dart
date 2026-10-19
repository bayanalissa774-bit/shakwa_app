import 'package:shakwa_app/features/notifications/data/datasources/notification_remote_data_source.dart';
import 'package:shakwa_app/features/notifications/domain/entities/notification_entity.dart';
import 'package:shakwa_app/features/notifications/domain/repositories/notification_repository.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource remoteDataSource;

  NotificationRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<NotificationEntity>> getNotifications() async {
    // 1. استدعاء الداتا من السيرفر عبر الـ Data Source
    final notificationModels = await remoteDataSource.getNotifications();

    // 2. إرجاع النتيجة (بما أن المودل يورث من الـ Entity، فينا نرجعه مباشرة)
    return notificationModels;
  }

  @override
  Future<void> markAllAsRead() async {
    // إرسال أمر السيرفر بتحديث الكل كمقروء
    await remoteDataSource.markAllAsRead();
  }
}
