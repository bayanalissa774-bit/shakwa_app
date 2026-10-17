import 'package:dartz/dartz.dart';

import '../../domain/entities/complaint_entity.dart';
import '../../domain/repositories/complaints_repository.dart';
import '../datasources/complaints_remote_data_source.dart';
import '../models/complaint_model.dart';

class ComplaintsRepositoryImpl implements ComplaintsRepository {
  final ComplaintsRemoteDataSource remoteDataSource;

  ComplaintsRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<String, List<ComplaintEntity>>> getComplaints() async {
    try {
      // 1. استدعاء المندوب لجلب البيانات من الإنترنت
      final remoteComplaints = await remoteDataSource.getComplaints();

      // 2. إرجاع النتيجة بنجاح (اليمين)
      return Right(remoteComplaints);
    } catch (e) {
      // 3. في حال حدوث خطأ، إرجاع رسالة الخطأ (اليسار)
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> addComplaint(ComplaintEntity complaint) async {
    try {
      // 1. تحويل الـ Entity القادم من الـ Domain إلى ComplaintModel ليفهمه الـ Data Source
      final complaintModel = ComplaintModel(
        id: complaint.id,
        title: complaint.title,
        description: complaint.description,
        date: complaint.date,
        status: complaint.status,
      );

      // 2. إرسال الطلب للمندوب
      await remoteDataSource.addComplaint(complaintModel);

      // 3. إرجاع نجاح العملية (بدون بيانات)
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
