import 'package:dartz/dartz.dart';
import 'package:tasky_todo_app/core/errors/app_errors.dart';
import 'package:tasky_todo_app/features/auth/data/models/auth_info.dart';
import 'package:tasky_todo_app/features/auth/data/models/register_model.dart';

abstract class AuthRepo {
  Future<Either<Failures, void>> register(Register model);

  Future<Either<Failures, Authinfo>> login(Register model);

  Future<Either<Failures, void>> logout();
}
