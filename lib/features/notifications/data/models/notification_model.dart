import 'package:flutter/material.dart';
import 'package:shakwa_app/features/notifications/domain/entities/notification_entity.dart';

class NotificationModel extends NotificationEntity {
  const NotificationModel({
    required super.id,
    required super.title,
    required super.time,
    required super.type,
    required super.isRead,
    required super.icon,
  });

  // دالة لتحويل بيانات الـ JSON القادمة من السيرفر إلى نموذج إشعار
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    // دالة مساعدة لاختيار الأيقونة المناسبة حسب نوع الإشعار القادم من السيرفر
    IconData getIconForType(String type) {
      switch (type) {
        case 'الشكاوي':
          return Icons.campaign_rounded;
        case 'الردود':
          return Icons.description_rounded;
        case 'الاخبار':
          return Icons.flag_rounded;
        default:
          return Icons.notifications_rounded;
      }
    }

    return NotificationModel(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      time: json['time'] ?? 'الآن',
      type: json['type'] ?? 'الكل',
      isRead: json['is_read'] ?? json['isRead'] ?? false,
      icon: getIconForType(json['type'] ?? ''),
    );
  }

  // دالة لتحويل النموذج إلى JSON (في حال أردنا إرسال بيانات للسيرفر مستقبلاً)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'time': time,
      'type': type,
      'isRead': isRead,
    };
  }
}
