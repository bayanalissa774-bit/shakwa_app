import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/home_stats_entity.dart';
import '../repositories/home_repository.dart';

class GetHomeStatsUseCase {
  final HomeRepository repository;

  GetHomeStatsUseCase(this.repository);

  Future<Either<Failure, HomeStatsEntity>> call() async {
    return await repository.getHomeStats();
  }
}