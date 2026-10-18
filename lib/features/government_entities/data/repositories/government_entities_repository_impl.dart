import '../../domain/entities/government_entity.dart';
import '../../domain/repositories/government_entities_repository.dart';
import '../datasources/government_entities_remote_data_source.dart';

class GovernmentEntitiesRepositoryImpl implements GovernmentEntitiesRepository {
  final GovernmentEntitiesRemoteDataSource remoteDataSource;

  GovernmentEntitiesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<GovernmentEntity>> getGovernmentEntities() async {
    // 1. نقوم باستدعاء الدالة من الـ DataSource لجلب البيانات من الإنترنت
    final remoteEntities = await remoteDataSource.getGovernmentEntities();

    // 2. نقوم بإرجاع القائمة (بما أن الـ Model يورث من الـ Entity، فيمكن إرجاعه مباشرة)
    return remoteEntities;
  }
}
