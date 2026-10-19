import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakwa_app/features/complaints/domain/entities/complaint_entity.dart';
import 'package:shakwa_app/features/complaints/domain/usecases/get_complaints_usecase.dart';
import 'package:shakwa_app/features/complaints/domain/usecases/add_complaint_usecase.dart';

import 'complaints_state.dart';

class ComplaintsCubit extends Cubit<ComplaintsState> {
  final GetComplaintsUseCase getComplaintsUseCase;
  final AddComplaintUseCase addComplaintUseCase;

  ComplaintsCubit({
    required this.getComplaintsUseCase,
    required this.addComplaintUseCase,
  }) : super(ComplaintsInitial());

  // دالة لجلب الشكاوى وعرضها
  Future<void> fetchComplaints() async {
    emit(ComplaintsLoading());
    final result = await getComplaintsUseCase();
    result.fold(
      (failureMessage) => emit(ComplaintsError(failureMessage)),
      (complaintsList) => emit(ComplaintsLoaded(complaintsList)),
    );
  }

  // دالة لإرسال شكوى جديدة للسيرفر
  Future<void> createComplaint({
    required String title,
    required String description,
    required int categoryId,
    required int citizenId,
    int? entityId,
  }) async {
    emit(ComplaintsLoading());

    // تجهيز كائن الشكوى الجديد بالاعتماد على ComplaintEntity
    final ComplaintEntity newComplaint = ComplaintEntity(
      id: '0',
      title: title,
      description: description,
      date: DateTime.now().toString().split(' ')[0],
      status: 'جديدة',
    );

    // إرسال الشكوى عبر الـ Use Case
    final result = await addComplaintUseCase(newComplaint);

    result.fold((failureMessage) => emit(ComplaintsError(failureMessage)), (
      _,
    ) async {
      emit(ComplaintsLoading());

      // بعد النجاح، نعيد جلب القائمة لتحديث الواجهة تلقائياً
      await fetchComplaints();
    });
  }
}
