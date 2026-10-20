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
      // هنا نقوم بإرسال الطلب للرابط الفعلي للسيرفر (Endpoint)
      final response = await dio.get(
        'https://palegoldenrod-rabbit-772161.hostingersite.com/api/v1/complaint/search.php', // (ضعي رابط الـ API الصحيح هنا لدتيكِ)
        queryParameters: {'id': complaintNumber},
      );

      if (response.statusCode == 200 && response.data != null) {
        return ComplaintModel.fromJson(response.data);
      } else {
        throw Exception('فشل في جلب بيانات الشكوى من السيرفر');
      }
    } catch (e) {
      throw Exception('خطأ في الاتصال بالإنترنت أو رقم الشكوى غير موجود');
    }
  }
}
