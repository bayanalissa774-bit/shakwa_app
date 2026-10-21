import 'package:dartz/dartz.dart';
import 'package:shakwa_app/core/errors/failures.dart';
import '../../domain/entities/home_stats_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_remote_data_source.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, HomeStatsEntity>> getHomeStats() async {
    try {
      // 1. جلب البيانات من السيرفر كـ Model
      final statsModel = await remoteDataSource.getHomeStats();
      // 2. إرجاعها بنجاح
      return Right(statsModel);
    } catch (e) {
      // 3. في حال حدث خطأ
      return Left(ServerFailure(e.toString()));
    }
  }
}