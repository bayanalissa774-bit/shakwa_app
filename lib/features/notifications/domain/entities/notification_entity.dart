import 'package:flutter/material.dart';

class NotificationEntity {
  final String id;
  final String title;
  final String time;
  final String type; // مثل: 'الشكاوي', 'الردود', 'الاخبار'
  final bool isRead;
  final IconData icon;

  const NotificationEntity({
    required this.id,
    required this.title,
    required this.time,
    required this.type,
    required this.isRead,
    required this.icon,
  });
}
