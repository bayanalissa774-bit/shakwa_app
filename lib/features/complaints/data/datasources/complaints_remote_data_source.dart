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
      // إرسال الطلب وحفظ النتيجة في متغير response
      final response = await dio.post(
        'https://palegoldenrod-rabbit-772161.hostingersite.com/api/v1/complaint/create.php',
        data: complaint.toJson(),
      );

      // طباعة الاستجابة عند النجاح
      print('================ SUCCESS ================');
      print('Status Code: ${response.statusCode}');
      print('Response Data: ${response.data}');
      print('=========================================');
    } on DioException catch (e) {
      // التعامل مع أخطاء Dio بشكل مفصل
      print('================ DIO ERROR ================');
      print('Error Type: ${e.type}');
      print('Message: ${e.message}');

      if (e.response != null) {
        // إذا كان هناك رد قادم من السيرفر (مثل 400, 404, 500)
        print('Status Code: ${e.response?.statusCode}');
        print('Server Response Data: ${e.response?.data}');
        print('Headers: ${e.response?.headers}');
      } else {
        // أخطاء الاتصال أو انتهاء وقت الانتظار (Timeout)
        print(
          'Error sending request (No response from server): ${e.requestOptions}',
        );
      }
      print('===========================================');

      throw Exception('فشل في إرسال الشكوى: ${e.response?.data ?? e.message}');
    } catch (e) {
      // التعامل مع الأخطاء العامة الأخرى
      print('================ UNKNOWN ERROR ================');
      print('General Error: $e');
      print('===============================================');

      throw Exception('حدث خطأ غير متوقع: $e');
    }
  }
}
