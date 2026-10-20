import 'package:dartz/dartz.dart';

import '../entities/track_entity.dart';

abstract class TrackRepository {
  Future<Either<String, TrackEntity>> trackComplaint(String complaintNumber);
}
