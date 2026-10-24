import 'dart:io';

import '../entities/citizen_entity.dart';

abstract class ProfileRepo {
  // دالة تحديث بيانات المواطن
  Future<CitizenEntity> updateProfile({
    required int citizenNumber,
    required String citizenName,
    required String phoneNumber,
    required String password,
    required String address,
    required String email,
    File? identityImage,
  });
}
