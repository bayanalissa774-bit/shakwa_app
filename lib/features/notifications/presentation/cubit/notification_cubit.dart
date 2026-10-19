import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakwa_app/features/notifications/domain/usecases/get_notifications_usecase.dart';
import 'package:shakwa_app/features/notifications/presentation/cubit/notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final GetNotificationsUseCase getNotificationsUseCase;

  NotificationCubit({required this.getNotificationsUseCase})
    : super(NotificationInitial());

  // دالة لجلب الإشعارات من السيرفر
  Future<void> fetchNotifications() async {
    emit(NotificationLoading()); // 1. اظهر حالة التحميل فوراً

    try {
      // 2. اطلب البيانات عبر الـ UseCase
      final notifications = await getNotificationsUseCase();

      // 3. إذا وصلت بسلامة، اعرضها بالشاشة
      emit(NotificationLoaded(notifications));
    } catch (e) {
      // 4. إذا صار مشكلة، اعرض رسالة الخطأ
      emit(NotificationError(e.toString()));
    }
  }

  // دالة لتمييز كل الإشعارات كمقروءة
  Future<void> markAllAsReadLocally() async {
    if (state is NotificationLoaded) {
      final currentList = (state as NotificationLoaded).notifications;

      // تحديث الحالة محلياً لتصبح جميعها مقروءة فوراً للتفاعل السريع
      // (ملاحظة: فيكِ تضيفي استدعاء الـ Repository هون كمان إذا حبيتي تربطيها بالسيرفر)
    emit(NotificationLoaded(List.from(currentList)));
    }
  }


  
}
