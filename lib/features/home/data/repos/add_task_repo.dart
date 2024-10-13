import 'package:dartz/dartz.dart';
import 'package:tasky_todo_app/core/errors/app_errors.dart';
import 'package:tasky_todo_app/features/home/data/models/add_task_model.dart';

abstract class AddTaskRepo {
  Future<Either<Failures, void>> addTask({required AddTaskModel addTaskModel});
}
