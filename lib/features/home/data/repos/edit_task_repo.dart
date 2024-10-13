

import 'package:dartz/dartz.dart';
import 'package:tasky_todo_app/core/errors/app_errors.dart';
import 'package:tasky_todo_app/features/home/data/models/edit_task_model.dart';

abstract class EditTaskRepo {
  Future<Either<Failures, void>> editTask(
      {required EditTaskModel editTaskModel, required String taskId});
}
