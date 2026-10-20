import 'package:dartz/dartz.dart';

import '../../domain/entities/track_entity.dart';
import '../../domain/repositories/track_repository.dart';
import '../datasources/track_remote_data_source.dart';

class TrackRepositoryImpl implements TrackRepository {
  final TrackRemoteDataSource remoteDataSource;

  TrackRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<String, TrackEntity>> trackComplaint(
    String complaintNumber,
  ) async {
    try {
      final complaintModel = await remoteDataSource.trackComplaint(
        complaintNumber,
      );
      return Right(complaintModel);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
