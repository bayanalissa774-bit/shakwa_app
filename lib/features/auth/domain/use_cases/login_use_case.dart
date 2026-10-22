import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/citizen_entity.dart';
import '../repositories/base_auth_repository.dart';

class LoginUseCase {
  final BaseAuthRepository repository;

  LoginUseCase(this.repository);

  // استخدام callable class (تنفيذ الكلاس كأنه دالة) عبر استدعاء call
  Future<Either<Failure, CitizenEntity>> call({
    required String phoneNumber,
    required String password,
  }) async {
    return await repository.login(phoneNumber: phoneNumber, password: password);
  }
}
