import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakwa_app/features/auth/domain/use_cases/register_use_case.dart';

import '../../domain/use_cases/login_use_case.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;

  // البناء: نبدأ بالحالة الأولية AuthInitial عند فتح التطبيق
  AuthCubit({required this.loginUseCase, required this.registerUseCase})
    : super(AuthInitial());

  // دالة تسجيل الدخول التي سترتبط بزر LoginView
  Future<void> login({
    required String phoneNumber,
    required String password,
  }) async {
    // 1. نرسل حالة التحميل أولاً لكي تظهر دائرة التحميل على الشاشة
    emit(AuthLoading());

    // 2. نستدعي الـ UseCase لنفذ الطلب عبر الـ API
    final result = await loginUseCase(
      phoneNumber: phoneNumber,
      password: password,
    );

    // 3. نستخدم دالة fold للتعامل مع النتيجة (اليسار خطأ، اليمين نجاح)
    result.fold(
      (failure) =>
          emit(AuthError(failure.message)), // لو فشل، نبعث حالة الخطأ مع رسالته
      (citizen) => emit(
        AuthSuccess(citizen),
      ), // لو نجح، نبعث حالة النجاح وبيانات المواطن
    );
  }

  // 2. دالة إنشاء الحساب الجديدة (ضعي هذه الدالة هنا)
  Future<void> register({
    required String citizenName,
    required String phoneNumber,
    required String password,
    required String email,
    required String nationalId,
    String? identityImage,
  }) async {
    emit(AuthLoading());
    final result = await registerUseCase(
      citizenName: citizenName,
      phoneNumber: phoneNumber,
      password: password,
      email: email,
      nationalId: nationalId,
      identityImage: identityImage ?? "",
    );
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (citizen) => emit(AuthSuccess(citizen)),
    );
  }
}
