import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_news_usecase.dart';
import 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  final GetNewsUseCase getNewsUseCase;

  NewsCubit({required this.getNewsUseCase}) : super(NewsInitial());

  // دالة جلب الأخبار
  Future<void> fetchNews() async {
    emit(NewsLoading());
    try {
      final newsList = await getNewsUseCase();
      emit(NewsLoaded(newsList));
    } catch (e) {
      emit(NewsError('حدث خطأ أثناء تحميل الأخبار: ${e.toString()}'));
    }
  }
}
