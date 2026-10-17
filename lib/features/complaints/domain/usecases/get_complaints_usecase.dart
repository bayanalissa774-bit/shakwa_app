import 'package:dartz/dartz.dart';

import '../entities/complaint_entity.dart';
import '../repositories/complaints_repository.dart';

class GetComplaintsUseCase {
  final ComplaintsRepository repository;

  GetComplaintsUseCase(this.repository);

  Future<Either<String, List<ComplaintEntity>>> call() async {
    return await repository.getComplaints();
  }
}
