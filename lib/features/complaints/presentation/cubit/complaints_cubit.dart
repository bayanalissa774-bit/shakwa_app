import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_complaints_usecase.dart';
import 'complaints_state.dart';

class ComplaintsCubit extends Cubit<ComplaintsState> {
  final GetComplaintsUseCase getComplaintsUseCase;

  ComplaintsCubit({required this.getComplaintsUseCase})
    : super(ComplaintsInitial());

  // دالة لجلب الشكاوى من السيرفر
  Future<void> fetchComplaints() async {
    // 1. إعلام الواجهة بأننا بدأنا بالتحميل (Loading)
    emit(ComplaintsLoading());

    // 2. استدعاء الـ Use Case لجلب البيانات
    final result = await getComplaintsUseCase();

    // 3. التعامل مع النتيجة (Either: يسار خطأ، يمين نجاح)
    result.fold(
      (failureMessage) => emit(ComplaintsError(failureMessage)), // إذا صار خطأ
      (complaintsList) =>
          emit(ComplaintsLoaded(complaintsList)), // إذا نجحت العملية
    );
  }
}
