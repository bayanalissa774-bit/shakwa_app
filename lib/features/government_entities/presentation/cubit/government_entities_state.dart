import '../../domain/entities/government_entity.dart';

abstract class GovernmentEntitiesState {}

// 1. الحالة الأولية عند فتح الصفحة لأول مرة
class GovernmentEntitiesInitial extends GovernmentEntitiesState {}

// 2. حالة التحميل (عندما نبدأ بجلب البيانات من الإنترنت ونريد إظهار علامة التحميل Loading)
class GovernmentEntitiesLoading extends GovernmentEntitiesState {}

// 3. حالة النجاح (عندما تأتي البيانات بنجاح ونحمل القائمة لنعرضها)
class GovernmentEntitiesLoaded extends GovernmentEntitiesState {
  final List<GovernmentEntity> entities;

  GovernmentEntitiesLoaded(this.entities);
}

// 4. حالة الخطأ (لو حدث مشكلة في الإنترنت أو السيرفر)
class GovernmentEntitiesError extends GovernmentEntitiesState {
  final String message;

  GovernmentEntitiesError(this.message);
}
