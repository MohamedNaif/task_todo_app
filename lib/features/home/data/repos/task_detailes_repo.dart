
import 'package:dartz/dartz.dart';
import 'package:tasky_todo_app/core/errors/app_errors.dart';
import 'package:tasky_todo_app/features/home/data/models/task_model/task_model.dart';

abstract class TaskDetailsRepo {
  Future<Either<Failures, TaskModel>> getTaskDetailsData({required String taskId});
}
