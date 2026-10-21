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

  static String _mapStatus(String? serverStatus) {
    if (serverStatus == 'جديدة' || serverStatus == 'new') {
      return 'تحت المعالجة';
    }
    return serverStatus ?? 'تحت المعالجة';
  }

  factory ComplaintModel.fromJson(Map<String, dynamic> json) {
    return ComplaintModel(
      id: json['id']?.toString() ?? json['complaint_number']?.toString() ?? '',
      title: json['title_of_complaint'] ?? json['title'] ?? '',
      description: json['description_complaint'] ?? json['description'] ?? '',
      category: json['category_number']?.toString() ?? json['category'] ?? '',
      government:
          json['government_name'] ??
          json['government'] ??
          json['entity_name'] ??
          'الجهة المعنية',
      status: _mapStatus(json['complaint_status'] ?? json['status']),
      date:
          json['created_at'] ??
          json['date'] ??
          json['complaint_date'] ??
          json['date_time'] ??
          json['created_date'] ??
          'غير متوفر',
    );
  }
}
