part of 'profile_cubit.dart';



abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final CitizenEntity citizen;
  ProfileSuccess(this.citizen);
}

class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}
