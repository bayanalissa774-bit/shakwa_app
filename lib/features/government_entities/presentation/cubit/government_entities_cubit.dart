import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/government_entity.dart';
import '../../domain/usecases/get_government_entities_usecase.dart';
import 'government_entities_state.dart';

class GovernmentEntitiesCubit extends Cubit<GovernmentEntitiesState> {
  final GetGovernmentEntitiesUseCase getGovernmentEntitiesUseCase;

  // الاحتفاظ بالقائمة الأصلية الكاملة القادمة من الـ API
  List<GovernmentEntity> _allEntities = [];

  GovernmentEntitiesCubit(this.getGovernmentEntitiesUseCase)
    : super(GovernmentEntitiesInitial());

  Future<void> fetchGovernmentEntities() async {
    emit(GovernmentEntitiesLoading());

    try {
      final entities = await getGovernmentEntitiesUseCase();
      _allEntities = entities; // حفظ القائمة الأصلية
      emit(GovernmentEntitiesLoaded(entities));
    } catch (e) {
      emit(GovernmentEntitiesError(e.toString()));
    }
  }

  // 🔍 دالة التصفية والبحث
  void searchEntities(String query) {
    if (query.isEmpty) {
      // إذا كان مربع البحث فارغاً، نعيد القائمة الكاملة
      emit(GovernmentEntitiesLoaded(_allEntities));
    } else {
      // تصفية القائمة بناءً على اسم الجهة أو وصفها
      final filteredList = _allEntities.where((entity) {
        final name = entity.name.toLowerCase();
        final description = entity.description.toLowerCase();
        final searchLower = query.toLowerCase();

        return name.contains(searchLower) || description.contains(searchLower);
      }).toList();

      emit(GovernmentEntitiesLoaded(filteredList));
    }
  }
}
