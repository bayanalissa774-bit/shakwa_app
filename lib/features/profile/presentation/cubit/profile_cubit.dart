import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/citizen_entity.dart';
import '../../domain/use_cases/update_profile_use_case.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final UpdateProfileUseCase updateProfileUseCase;

  ProfileCubit({required this.updateProfileUseCase}) : super(ProfileInitial());

  // دالة التحديث التي يتم استدعاؤها من الواجهة
  Future<void> updateProfile({
    required int citizenNumber,
    required String citizenName,
    required String phoneNumber,
    required String password,
    required String address,
    required String email,
    File? identityImage,
  }) async {
    emit(ProfileLoading());

    try {
      final updatedCitizen = await updateProfileUseCase(
        citizenNumber: citizenNumber,
        citizenName: citizenName,
        phoneNumber: phoneNumber,
        password: password,
        address: address,
        email: email,
        identityImage: identityImage,
      );

      emit(ProfileSuccess(updatedCitizen));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}