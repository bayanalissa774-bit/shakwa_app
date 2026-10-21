import 'package:dartz/dartz.dart'; // إذا كنتِ تستخدمين مكتبة dartz للـ Either (أو استبدليها بالطريقة المعتمدة عندك)
import 'package:shakwa_app/core/errors/failures.dart';
import '../entities/home_stats_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, HomeStatsEntity>> getHomeStats();
}