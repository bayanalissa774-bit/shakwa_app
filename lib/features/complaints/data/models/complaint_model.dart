import '../../domain/entities/complaint_entity.dart';

class ComplaintModel extends ComplaintEntity {
  const ComplaintModel({
    required super.id,
    required super.title,
    required super.description,
    required super.date,
    required super.status,
  });

  // هذه الدالة تحول الـ JSON القادم من الـ API إلى ComplaintModel
  factory ComplaintModel.fromJson(Map<String, dynamic> json) {
    return ComplaintModel(
      id: json['complaint_number']?.toString() ?? '',
      title: json['title_of_complaint'] ?? '',
      description: json['description_complaint'] ?? '',
      date: json['created_at'] ?? '2026',
      status: json['complaint_status'] ?? 'جديدة',
    );
  }

  // هذه الدالة تحول البيانات إلى JSON لإرسالها للـ API عند إنشاء شكوى جديدة
  Map<String, dynamic> toJson() {
    return {
      "title_of_complaint": title,
      "description_complaint": description,
      "complaint_status": status,
      "complaint_priority": "متوسطة",
      "citizen_number": 1,
      "category_number": 1,
    };
  }
}
