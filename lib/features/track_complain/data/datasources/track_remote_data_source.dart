// ignore_for_file: avoid_print

import 'package:dio/dio.dart';

import '../models/complaint_model.dart';

abstract class TrackRemoteDataSource {
  Future<ComplaintModel> trackComplaint(String complaintNumber);
}

class TrackRemoteDataSourceImpl implements TrackRemoteDataSource {
  final Dio dio;

  TrackRemoteDataSourceImpl(this.dio);

  @override
  Future<ComplaintModel> trackComplaint(String complaintNumber) async {
    try {
      final response = await dio.get(
        'https://palegoldenrod-rabbit-772161.hostingersite.com/api/v1/complaint/search.php',
        queryParameters: {'keyword': complaintNumber},
        options: Options(
          headers: {
            'Accept': 'application/json',
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)',
          },
        ),
      );

      print('RESPONSE DATA: ${response.data}');

      if (response.statusCode == 200 && response.data != null) {
        final List complaintsList = response.data['data'] ?? [];

        if (complaintsList.isNotEmpty) {
          return ComplaintModel.fromJson(complaintsList[0]);
        } else {
          throw Exception('لا يوجد نتائج مطابقة');
        }
      } else {
        throw Exception('فشل في جلب البيانات من السيرفر');
      }
    } catch (e) {
      throw Exception('خطأ في الاتصال بالإنترنت أو رقم الشكوى غير موجود: $e');
    }
  }
}
