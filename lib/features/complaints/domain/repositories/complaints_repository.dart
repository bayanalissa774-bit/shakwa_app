import 'package:dartz/dartz.dart'; // سنستخدمه لاحقاً للتعامل مع الأخطاء بأمان
import '../entities/complaint_entity.dart';

abstract class ComplaintsRepository {
  Future<Either<String, List<ComplaintEntity>>> getComplaints();
  Future<Either<String, void>> addComplaint(ComplaintEntity complaint);
}