import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/citizen_entity.dart';
import '../../domain/repositories/base_auth_repository.dart';
import '../data_sources/auth_remote_data_source.dart';
import '../models/citizen_model.dart';
import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'dart:developer' as developer;

class AuthRepositoryImpl implements BaseAuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, CitizenEntity>> login({
    required String phoneNumber,
    required String password,
  }) async {
    try {
      final citizenModel = await remoteDataSource.login(
        phoneNumber: phoneNumber,
        password: password,
      );
      return Right(citizenModel);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CitizenEntity>> register({
    required String citizenName,
    required String email,
    required String identityImage,
    required String nationalId,
    required String password,
    required String phoneNumber,
  }) async {
    // 1. تتبع مدخلات الدالة للتأكد من أن البيانات قادمة بشكل صحيح من الطبقات السابقة (Bloc / UI)
    developer.log(
      '🟢 [Register Repo] Start register process with data:\n'
      'Name: $citizenName | Email: $email | Phone: $phoneNumber | NationalID: $nationalId',
      name: 'CitizenRepository',
    );

    CitizenModel? citizenModel;

    // الخطوة الأولى: إنشاء الـ Model
    try {
      developer.log(
        '🟡 [Register Repo] Step 1: Creating CitizenModel...',
        name: 'CitizenRepository',
      );

      citizenModel = CitizenModel(
        citizenName: citizenName,
        email: email,
        identityImage: identityImage,
        nationalId: nationalId,
        password: password,
        phoneNumber: phoneNumber,
      );

      developer.log(
        '🟢 [Register Repo] Step 1 Success: CitizenModel created successfully.',
        name: 'CitizenRepository',
      );
    } catch (e, stackTrace) {
      developer.log(
        '🔴 [Register Repo] ERROR in Step 1 (Creating CitizenModel): $e',
        error: e,
        stackTrace: stackTrace,
        name: 'CitizenRepository',
      );
      return Left(ServerFailure('Error in creating model: ${e.toString()}'));
    }

    // الخطوة الثانية: الاتصال بـ Remote Data Source
    try {
      developer.log(
        '🟡 [Register Repo] Step 2: Calling remoteDataSource.register()...',
        name: 'CitizenRepository',
      );

      final citizen = await remoteDataSource.register(
        citizenModel: citizenModel,
        password: password,
      );

      developer.log(
        '🟢 [Register Repo] Step 2 Success: Remote registration completed. Response received: $citizen',
        name: 'CitizenRepository',
      );

      return Right(citizen);
    } catch (e, stackTrace) {
      // هنا يتم التقاط أخطاء الـ API أو الـ Network أو الـ Parsing بشكل دقيق مع الـ StackTrace لمعرفة مكان الخطأ في الـ RemoteDataSource أيضاً
      developer.log(
        '🔴 [Register Repo] ERROR in Step 2 (Remote Data Source call failed): $e',
        error: e,
        stackTrace: stackTrace,
        name: 'CitizenRepository',
      );

      return Left(ServerFailure(e.toString()));
    }
  }
}
