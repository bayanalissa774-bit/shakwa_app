import 'package:dartz/dartz.dart';
import '../entities/track_entity.dart';
import '../repositories/track_repository.dart';

class TrackComplaintUseCase {
  final TrackRepository repository;

  TrackComplaintUseCase(this.repository);

  Future<Either<String, TrackEntity>> call(String complaintNumber) async {
    return await repository.trackComplaint(complaintNumber);
  }
}