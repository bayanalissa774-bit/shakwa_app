import '../entities/government_entity.dart';

abstract class GovernmentEntitiesRepository {
  Future<List<GovernmentEntity>> getGovernmentEntities();
}