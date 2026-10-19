import 'dart:convert';

import 'package:dio/dio.dart';

import '../models/news_model.dart';

abstract class NewsRemoteDataSource {
  Future<List<NewsModel>> getNews();
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final Dio dio;

  NewsRemoteDataSourceImpl(this.dio);

  @override
  Future<List<NewsModel>> getNews() async {
    try {
      // 👈 استخدام الرابط الحقيقي الصحيح المستخرج من ملف الـ Postman
      final response = await dio.get(
        'https://palegoldenrod-rabbit-772161.hostingersite.com/api/v1/news/get.php',
        options: Options(headers: {'Accept': 'application/json'}),
      );

      dynamic responseData = response.data;

      if (responseData is String) {
        responseData = jsonDecode(responseData);
      }

      if (responseData is List) {
        return responseData.map((json) => NewsModel.fromJson(json)).toList();
      } else if (responseData is Map<String, dynamic>) {
        // غالباً الـ API يعيد البيانات داخل مفتاح مثل 'data' أو 'news' أو مباشرة
        final List list = responseData['data'] ?? responseData['news'] ?? [];
        return list.map((json) => NewsModel.fromJson(json)).toList();
      }

      return [];
    } on DioException catch (e) {
      throw Exception(
        'فشل الاتصال بالسيرفر: ${e.response?.statusCode ?? e.message}',
      );
    }
  }
}
