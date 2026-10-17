import 'package:dio/dio.dart';
import 'package:shakwa_app/features/complaints/data/models/complaint_model.dart';

// ignore: duplicate_import
import '../models/complaint_model.dart';

abstract class ComplaintsRemoteDataSource {
  Future<List<ComplaintModel>> getComplaints();
  Future<void> addComplaint(ComplaintModel complaint);
}

class ComplaintsRemoteDataSourceImpl implements ComplaintsRemoteDataSource {
  final Dio dio;

  ComplaintsRemoteDataSourceImpl(this.dio);

  @override
  Future<List<ComplaintModel>> getComplaints() async {
    try {
      // وضعنا الرابط كاملاً هنا لمنع خطأ No host specified
      final response = await dio.get(
        'https://palegoldenrod-rabbit-772161.hostingersite.com/api/v1/complaint/get.php',
      );

      if (response.statusCode == 200) {
        final responseData = response.data;

        List dataList = [];
        if (responseData is List) {
          dataList = responseData;
        } else if (responseData is Map && responseData.containsKey('data')) {
          dataList = responseData['data'];
        } else if (responseData is Map) {
          dataList = responseData.values
              .whereType<List>()
              .expand((x) => x)
              .toList();
        }

        return dataList.map((json) => ComplaintModel.fromJson(json)).toList();
      } else {
        throw Exception('فشل في جلب البيانات من السيرفر');
      }
    } catch (e) {
      throw Exception('خطأ في الاتصال: $e');
    }
  }

  @override
  Future<void> addComplaint(ComplaintModel complaint) async {
    try {
      await dio.post(
        'https://palegoldenrod-rabbit-772161.hostingersite.com/api/v1/complaint/create.php',
        data: complaint.toJson(),
      );
    } catch (e) {
      throw Exception('فشل في إرسال الشكوى: $e');
    }
  }
}
