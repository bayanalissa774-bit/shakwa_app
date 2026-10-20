import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/track_complaint_usecase.dart';
import 'track_state.dart';

class TrackCubit extends Cubit<TrackState> {
  final TrackComplaintUseCase trackComplaintUseCase;

  TrackCubit({required this.trackComplaintUseCase}) : super(TrackInitial());

  Future<void> trackComplaint(String complaintNumber) async {
    emit(TrackLoading()); // 1. البدء بالتحميل

    final result = await trackComplaintUseCase(complaintNumber);

    result.fold(
      (failure) => emit(TrackError(failure)), // 2. في حالة الخطأ
      (complaint) => emit(TrackLoaded(complaint)), // 3. في حالة النجاح
    );
  }
}
