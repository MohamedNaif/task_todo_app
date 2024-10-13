part of 'profile_cubit_cubit.dart';

@immutable
sealed class ProfileCubitState {}

final class ProfileCubitInitial extends ProfileCubitState {}

final class ProfileCubitLoading extends ProfileCubitState {}

final class ProfileCubitSuccess extends ProfileCubitState {
  final UserData userData;

  ProfileCubitSuccess(this.userData);
}

final class ProfileCubitError extends ProfileCubitState {
  final String errMessage;

  ProfileCubitError(this.errMessage);
}
