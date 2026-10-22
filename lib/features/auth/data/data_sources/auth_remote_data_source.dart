import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

import '../models/citizen_model.dart';

abstract class AuthRemoteDataSource {
  Future<CitizenModel> login({
    required String phoneNumber,
    required String password,
  });
  Future<CitizenModel> register({
    required CitizenModel citizenModel,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl({required this.dio});

  @override
  Future<CitizenModel> login({
    required String phoneNumber,
    required String password,
  }) async {
    // رابط الـ API الخاص بتسجيل دخول المواطن من الـ Postman
    final response = await dio.post(
      'https://palegoldenrod-rabbit-772161.hostingersite.com/api/v1/citizen/login.php',
      data: {'phone_number': phoneNumber, 'password': password},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return CitizenModel.fromJson(response.data);
    } else {
      throw Exception('فشل تسجيل الدخول، تأكد من البيانات');
    }
  }

  @override
  Future<CitizenModel> register({
    required CitizenModel citizenModel,
    required String password,
  }) async {
    // 1. تحويل الصورة إلى Base64 إذا كانت موجودة
    String base64Image = '';
    final String imagePath = citizenModel.identityImage ?? '';

    if (imagePath.isNotEmpty) {
      try {
        final bytes = await File(imagePath).readAsBytes();
        base64Image = base64Encode(bytes);
      } catch (e) {
        log("⚠️ Failed to convert image to base64: $e");
      }
    }

    // 2. تجهيز البيانات على شكل JSON Map (تطابق الـ Postman تماماً)
    final Map<String, dynamic> requestBody = {
      "citizen_name": citizenModel.citizenName,
      "phone_number": citizenModel.phoneNumber,
      "password": password,
      "e_mail": citizenModel.email, // 👈 لاحظ استخدام e_mail بالأسفل
      "national_id": citizenModel.nationalId,
      "identity_image": base64Image, // 👈 إرسال الصورة كـ Base64
    };

    // طباعة البيانات للتأكد
    log('''
  ========== [ Citizen Registration JSON Data ] ==========
  - Citizen Name  : ${citizenModel.citizenName}
  - Phone Number  : ${citizenModel.phoneNumber}
  - Email (e_mail): ${citizenModel.email}
  - National ID   : ${citizenModel.nationalId}
  - Password      : ${password.isNotEmpty ? password : 'Empty'}
  - Has Image     : ${base64Image.isNotEmpty ? 'Yes (Base64)' : 'No Image'}
  =======================================================
  ''');

    try {
      // 3. إرسال الطلب كـ JSON
      final response = await dio.post(
        'https://palegoldenrod-rabbit-772161.hostingersite.com/api/v1/citizen/create.php',
        data: requestBody,
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      log("response.data ------ :::: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return CitizenModel.fromJson(response.data);
      } else {
        throw Exception('فشل إنشاء الحساب');
      }
    } on DioException catch (e) {
      // التقاط رسالة الخطأ من السيرفر إن وجدت
      log("❌ Server Error Response: ${e.response?.data}");
      final errorMessage =
          e.response?.data['message'] ?? e.response?.data['error'] ?? e.message;
      throw Exception(errorMessage);
    }
  }
}
