import 'dart:io';
import '../../domain/entities/citizen_entity.dart';
import '../../domain/repositories/profile_repo.dart';
import '../data_sources/profile_remote_data_source.dart';

class ProfileRepoImpl implements ProfileRepo {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepoImpl({required this.remoteDataSource});

  @override
  Future<CitizenEntity> updateProfile({
    required int citizenNumber,
    required String citizenName,
    required String phoneNumber,
    required String password,
    required String address,
    required String email,
    File? identityImage,
  }) async {
    // استدعاء الدالة من الـ Remote Data Source وإرجاع النتيجة كـ Entity
    final citizenModel = await remoteDataSource.updateProfile(
      citizenNumber: citizenNumber,
      citizenName: citizenName,
      phoneNumber: phoneNumber,
      password: password,
      address: address,
      email: email,
      identityImage: identityImage,
    );

    return citizenModel; // بما أن الـ Model يورث من الـ Entity، يمكننا إرجاعه مباشرة
  }
}