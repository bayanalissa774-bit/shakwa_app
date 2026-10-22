// 1. كلاس أب يجمع كل حالات المصادقة
abstract class AuthState {}

// 2. الحالة الأولى: لما تفتح الشاشة أول مرة (ساكنة)
class AuthInitial extends AuthState {}

// 3. حالة التحميل: لما المستخدم يضغط تسجيل الدخول ونحن عم نستنى رد السيرفر
class AuthLoading extends AuthState {}

// 4. حالة النجاح: لما السيرفر يوافق ويقلك تمام (وبنحفظ بيانات المواطن معنا)
class AuthSuccess extends AuthState {
  final dynamic citizen;
  AuthSuccess(this.citizen);
}

// 5. حالة الخطأ: لما يصير في مشكلة (مثل كلمة سر غلط أو نت مقطوع)
class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}
