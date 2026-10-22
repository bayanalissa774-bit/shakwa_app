import 'dart:io';

import '../entities/citizen_entity.dart';
import '../repositories/profile_repo.dart';

class UpdateProfileUseCase {
  final ProfileRepo repository;

  // نقوم بحقن الـ Repository هنا (Dependency Injection)
  UpdateProfileUseCase(this.repository);

  // دالة الـ call لتنفيذ المهمة مباشرة عند استدعاء الـ Use Case كأنه دالة
  Future<CitizenEntity> call({
    required int citizenNumber,
    required String citizenName,
    required String phoneNumber,
    required String password,
    required String address,
    required String email,
    File? identityImage,
  }) async {
    return await repository.updateProfile(
      citizenNumber: citizenNumber,
      citizenName: citizenName,
      phoneNumber: phoneNumber,
      password: password,
      address: address,
      email: email,
      identityImage: identityImage,
    );
  }
}
