import 'package:shakwa_app/features/notifications/domain/entities/notification_entity.dart';
import 'package:equatable/equatable.dart';
abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

// 1. الحالة الابتدائية عند فتح الصفحة أول مرة
class NotificationInitial extends NotificationState {}

// 2. حالة التحميل (عم نجيب البيانات من السيرفر)
class NotificationLoading extends NotificationState {}

// 3. حالة النجاح (وصلت الإشعارات وصارت جاهزة للعرض)
class NotificationLoaded extends NotificationState {
  final List<NotificationEntity> notifications;

  const NotificationLoaded(this.notifications);

  @override
  List<Object> get props => [notifications];
}

// 4. حالة حدوث خطأ بالاتصال
class NotificationError extends NotificationState {
  final String message;

  const NotificationError(this.message);

  @override
  List<Object> get props => [message];
}
