import 'package:dartz/dartz.dart'; // لتنفيذ إدارة الأخطاء (Either)

import '../../../../core/errors/failures.dart';
import '../entities/citizen_entity.dart';

abstract class BaseAuthRepository {
  // دالة تسجيل الدخول
  Future<Either<Failure, CitizenEntity>> login({
    required String phoneNumber,
    required String password,
  });

  // دالة إنشاء حساب جديد
  Future<Either<Failure, CitizenEntity>> register({
    required String citizenName,
    required String phoneNumber,
    required String password,
    required String email,
    required String nationalId,
    required String identityImage,
  });
}
