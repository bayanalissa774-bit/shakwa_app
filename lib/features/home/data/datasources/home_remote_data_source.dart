import 'package:dio/dio.dart';

import '../models/home_stats_model.dart';

abstract class HomeRemoteDataSource {
  Future<HomeStatsModel> getHomeStats();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final Dio dio;

  HomeRemoteDataSourceImpl(this.dio);

  @override
  @override
  Future<HomeStatsModel> getHomeStats() async {
    final response = await dio.get(
      'https://palegoldenrod-rabbit-772161.hostingersite.com/api/v1/complaint/get.php',
    );

    if (response.statusCode == 200 && response.data != null) {
      // افترضنا أن الـ API يرجع قائمة من الشكاوى
      final List complaints = response.data['data'] ?? response.data;

      int resolved = 0;
      int inProgress = 0;
      int pending = 0;

      // حساب عدد الشكاوى بحسب حالتها
      for (var complaint in complaints) {
        final status = complaint['complaint_status'] ?? '';
        if (status == 'تم الحل' || status == 'منجزة') {
          resolved++;
        } else if (status == 'قيد التنفيذ' || status == 'قيد المعالجة') {
          inProgress++;
        } else {
          pending++;
        }
      }

      // إرجاع النتيجة كنموذج إحصائيات للـ Home
      return HomeStatsModel(
        resolvedCount: resolved,
        inProgressCount: inProgress,
        pendingCount: pending,
      );
    } else {
      throw Exception('فشل في جلب الإحصائيات');
    }
  }
}
