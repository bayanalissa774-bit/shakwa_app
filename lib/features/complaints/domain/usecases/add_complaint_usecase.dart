import 'package:dartz/dartz.dart';
import 'package:shakwa_app/features/complaints/domain/entities/complaint_entity.dart';
import 'package:shakwa_app/features/complaints/domain/repositories/complaints_repository.dart';

class AddComplaintUseCase {
  final ComplaintsRepository repository;

  AddComplaintUseCase(this.repository);

  Future<Either<String, void>> call(ComplaintEntity complaint) async {
    return await repository.addComplaint(complaint);
  }
}
