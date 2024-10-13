
import 'package:dartz/dartz.dart';
import 'package:tasky_todo_app/core/errors/app_errors.dart';

abstract class DeleteTaskRepo {
  Future<Either<Failures, void>> deleteTask({required String taskId});
}
