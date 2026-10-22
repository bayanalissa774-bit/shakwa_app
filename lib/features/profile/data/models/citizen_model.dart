import '../../domain/entities/citizen_entity.dart';

class CitizenModel extends CitizenEntity {
  const CitizenModel({
    super.citizenNumber,
    required super.citizenName,
    required super.phoneNumber,
    required super.email,
    required super.nationalId,
    super.address,
    super.identityImage,
  });

  // تحويل البيانات القادمة من الـ API (JSON) إلى Model
  factory CitizenModel.fromJson(Map<String, dynamic> json) {
    return CitizenModel(
      citizenNumber: json['citizen_number'],
      citizenName: json['citizen_name'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      email: json['email'] ?? '',
      nationalId: json['national_id'] ?? '',
      address: json['address'],
      identityImage: json['identity_image'],
    );
  }

  // تحويل الـ Model إلى JSON (إذا احتجنا إرسالها)
  Map<String, dynamic> toJson() {
    return {
      'citizen_number': citizenNumber,
      'citizen_name': citizenName,
      'phone_number': phoneNumber,
      'email': email,
      'national_id': nationalId,
      'address': address,
      'identity_image': identityImage,
    };
  }
}
