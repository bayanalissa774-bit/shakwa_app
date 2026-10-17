import '../../domain/entities/complaint_entity.dart';

abstract class ComplaintsState {}

// 1. الحالة الابتدائية قبل أي طلب
class ComplaintsInitial extends ComplaintsState {}

// 2. حالة التحميل (عندما ينتظر التطبيق رداً من السيرفر لإظهار مؤشر التحميل)
class ComplaintsLoading extends ComplaintsState {}

// 3. حالة النجاح (عندما تصل البيانات بنجاح لنعرضها في القائمة)
class ComplaintsLoaded extends ComplaintsState {
  final List<ComplaintEntity> complaints;
  ComplaintsLoaded(this.complaints);
}

// 4. حالة الخطأ (عندما ينقطع الإنترنت أو يحدث مشكلة لنعرض رسالة للمستخدم)
class ComplaintsError extends ComplaintsState {
  final String message;
  ComplaintsError(this.message);
}
