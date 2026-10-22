import '../../domain/entities/citizen_entity.dart';

class CitizenModel extends CitizenEntity {
  final String? password; // أضفنا كلمة المرور هنا لتكون متاحة وقت الحاجة
  // في ملف citizen_model.dart
  final String? identityImage; // اجعليها اختيارية هكذا

  const CitizenModel({
    super.citizenNumber,
    required super.citizenName,
    required super.phoneNumber,
    required super.email,
    required super.nationalId,
    super.address,
    this.password,
    this.identityImage, // بدون كلمة required هنا لكي لا تسبب خطأ في اللوجن
  });

  factory CitizenModel.fromJson(Map<String, dynamic> json) {
    return CitizenModel(
      citizenNumber: json['citizen_number'] ?? json['id'],
      citizenName: json['citizen_name'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      email: json['e_mail'] ?? '',
      nationalId: json['national_id'] ?? '',
      address: json['the_address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'citizen_name': citizenName,
      'phone_number': phoneNumber,
      'email': email,
      'national_id': nationalId,
      'password': password,
      'identity_image':
          identityImage, // أضيفيها هنا لتُرسل للسيرفر مع البيانات عند التسجيل
    };
  }
}
