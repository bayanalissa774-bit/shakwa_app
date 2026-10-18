import '../entities/government_entity.dart';
import '../repositories/government_entities_repository.dart';

class GetGovernmentEntitiesUseCase {
  final GovernmentEntitiesRepository repository;

  GetGovernmentEntitiesUseCase(this.repository);

  Future<List<GovernmentEntity>> call() async {
    return await repository.getGovernmentEntities();
  }
}