import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/citizen_entity.dart';
import '../repositories/base_auth_repository.dart';

class RegisterUseCase {
  final BaseAuthRepository repository;

  RegisterUseCase(this.repository);

  // دالة الاستدعاء لإنشاء حساب جديد
  Future<Either<Failure, CitizenEntity>> call({
    required String citizenName,
    required String phoneNumber,
    required String password,
    required String email,
    required String nationalId,
    required String identityImage,
  }) async {
    return await repository.register(
      citizenName: citizenName,
      phoneNumber: phoneNumber,
      password: password,
      email: email,
      nationalId: nationalId,
      identityImage: identityImage,
    );
  }
}