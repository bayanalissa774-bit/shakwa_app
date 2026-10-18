import 'package:dio/dio.dart';

import '../models/government_entity_model.dart';

abstract class GovernmentEntitiesRemoteDataSource {
  Future<List<GovernmentEntityModel>> getGovernmentEntities();
}

class GovernmentEntitiesRemoteDataSourceImpl
    implements GovernmentEntitiesRemoteDataSource {
  final Dio dio;

  GovernmentEntitiesRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<GovernmentEntityModel>> getGovernmentEntities() async {
    try {
      // استبدلي هذا الرابط برابط الـ API الفعلي الخاص بالجهات الحكومية في مشروعك
      final response = await dio.get(
        'https://palegoldenrod-rabbit-772161.hostingersite.com/api/v1/target_entity/get.php',
      );

      if (response.statusCode == 200) {
        // افترضنا أن الـ API يرجع قائمة (List) داخل الـ data أو مباشرة
        final List data = response.data['data'] ?? response.data;

        return data
            .map((json) => GovernmentEntityModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load government entities');
      }
    } catch (e) {
      throw Exception('Error: ${e.toString()}');
    }
  }
}
