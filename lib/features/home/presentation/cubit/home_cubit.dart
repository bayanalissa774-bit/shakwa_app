// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_home_stats_usecase.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetHomeStatsUseCase getHomeStatsUseCase;

  HomeCubit(this.getHomeStatsUseCase) : super(HomeInitial());

Future<void> fetchHomeStats() async {
  emit(HomeLoading());

  final result = await getHomeStatsUseCase();

  result.fold(
    (failure) {
      print('==== API ERROR: ${failure.message} ====');
      emit(HomeError(failure.message));
    },
    (statsEntity) => emit(HomeLoaded(statsEntity)),
  );
}
}