import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import '../models/citizen_model.dart';

abstract class ProfileRemoteDataSource {
  Future<CitizenModel> updateProfile({
    required int citizenNumber,
    required String citizenName,
    required String phoneNumber,
    required String password,
    required String address,
    required String email,
    File? identityImage,
  });
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final Dio dio;

  ProfileRemoteDataSourceImpl({required this.dio});

  @override
  Future<CitizenModel> updateProfile({
    required int citizenNumber,
    required String citizenName,
    required String phoneNumber,
    required String password,
    required String address,
    required String email,
    File? identityImage,
  }) async {
    try {
      String? base64Image;

      // 1. إذا وُجدت صورة، نقوم بقراءتها وتحويلها إلى Base64 String
      if (identityImage != null) {
        List<int> imageBytes = await identityImage.readAsBytes();
        base64Image = base64Encode(imageBytes);
      }

      // 2. تجهيز البيانات كـ Map عادية (JSON Body)
      final Map<String, dynamic> requestData = {
        'citizen_number': citizenNumber,
        'citizen_name': citizenName,
        'phone_number': phoneNumber,
        'password': password,
        'address': address,
        'email': email,
        if (base64Image != null) 'identity_image': base64Image,
      };

      // 3. إرسال طلب الـ PUT مع الـ Body العادي
      final response = await dio.put(
        'https://palegoldenrod-rabbit-772161.hostingersite.com/api/v1/citizen/update.php',
        data: requestData,
      );

      // 4. التحقق من الاستجابة وإرجاع الـ Model
      if (response.statusCode == 200) {
        return CitizenModel.fromJson(response.data['data'] ?? response.data);
      } else {
        throw Exception(response.data['message'] ?? 'فشل تحديث البيانات');
      }
    } catch (e) {
      throw Exception('خطأ في الاتصال: $e');
    }
  }
}