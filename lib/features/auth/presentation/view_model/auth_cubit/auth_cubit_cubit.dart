import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:tasky_todo_app/core/errors/app_errors.dart';
import 'package:tasky_todo_app/features/auth/data/models/auth_info.dart';
import 'package:tasky_todo_app/features/auth/data/models/register_model.dart';
import 'package:tasky_todo_app/features/auth/data/repos/auth_repo.dart';

part 'auth_cubit_state.dart';

class AuthCubitCubit extends Cubit<AuthCubitState> {
  AuthCubitCubit(this._authRepo) : super(AuthCubitInitial());


  final AuthRepo _authRepo;
  Authinfo? authinfo; 

  Future<void> register(Register model) async {
    emit(RegisterLoading());
    final Either<Failures, void> result = await _authRepo.register(model);
    result.fold((error) {
      emit(RegisterError(error.errMessage));
    }, (success) {
      emit(RegisterSuccess());
    });
  }

  Future<void> login(Register model) async {
    emit(LoginLoading());
    final Either<Failures, Authinfo> result = await _authRepo.login(model);
    result.fold((error) {
      emit(LoginError(error.errMessage));
    }, (success) {
      emit(LoginSuccess( ));
      authinfo = success;
    });
  }

  Future<void> logout() async {
    emit(LogoutLoading());
    final Either<Failures, void> result = await _authRepo.logout();
    result.fold((error) {
      emit(LogoutError(error.errMessage));
    }, (success) {
      emit(LogoutSuccess());
    });
  }
}
