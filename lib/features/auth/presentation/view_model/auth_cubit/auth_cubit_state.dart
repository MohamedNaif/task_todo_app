part of 'auth_cubit_cubit.dart';

@immutable
sealed class AuthCubitState {}

final class AuthCubitInitial extends AuthCubitState {}

/////////////////////////////////////////////

final class RegisterLoading extends AuthCubitState {}

final class RegisterError extends AuthCubitState {
  final String errMessage;
  RegisterError(this.errMessage);
}

final class RegisterSuccess extends AuthCubitState {}

/////////////////////////////////////////////

final class LoginLoading extends AuthCubitState {}

final class LoginError extends AuthCubitState {
  final String errMessage;

  LoginError(this.errMessage);
}

final class LoginSuccess extends AuthCubitState {}

/////////////////////////////////////////////

final class LogoutSuccess extends AuthCubitState {}

final class LogoutError extends AuthCubitState {
  final String errMessage;

  LogoutError(this.errMessage);
}

final class LogoutLoading extends AuthCubitState {}
