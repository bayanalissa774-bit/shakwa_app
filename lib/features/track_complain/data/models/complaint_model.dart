import '../../domain/entities/track_entity.dart';

class ComplaintModel extends TrackEntity {
  const ComplaintModel({
    required super.id,
    required super.title,
    required super.description,
    required super.category,
    required super.government,
    required super.status,
    required super.date,
  });

  // هذه الدالة مهمتها "الترجمة": تأخذ الـ JSON القادم من السيرفر وتحوله إلى نموذج يفهمه التطبيق
  factory ComplaintModel.fromJson(Map<String, dynamic> json) {
    return ComplaintModel(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      government: json['government'] ?? '',
      status: json['status'] ?? 'تحت المعالجة',
      date: json['date'] ?? '',
    );
  }
}