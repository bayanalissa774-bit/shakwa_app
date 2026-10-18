
import '../../domain/entities/government_entity.dart';

class GovernmentEntityModel extends GovernmentEntity {
  const GovernmentEntityModel({
    required super.id,
    required super.name,
    required super.description,
    super.icon,
  });

  factory GovernmentEntityModel.fromJson(Map<String, dynamic> json) {
    return GovernmentEntityModel(
      id: json['entity_number'] ?? 0, // اعتماداً على الحقل في الـ API
      name: json['name_of_the_entity'] ?? '',
      description: json['description_of_the_entity'] ?? '',
      icon: json['contact_information'], // أو تخزين الأيقونة حسب المتوفر
    );
  }
}
