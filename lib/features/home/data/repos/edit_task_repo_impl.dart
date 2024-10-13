


import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tasky_todo_app/core/errors/app_errors.dart';
import 'package:tasky_todo_app/core/helper/api_services.dart';
import 'package:tasky_todo_app/core/helper/constant.dart';
import 'package:tasky_todo_app/features/home/data/models/edit_task_model.dart';
import 'package:tasky_todo_app/features/home/data/repos/edit_task_repo.dart';

class EditTaskRepoImpl implements EditTaskRepo {
  final ApiServices _apiServices;

  EditTaskRepoImpl(this._apiServices);

  @override
  Future<Either<Failures, void>> editTask(
      {required EditTaskModel editTaskModel, required String taskId}) async {
    try {
      await _apiServices.request(
        method: 'PUT',
        endPoint: '${EndPoints.todos}/$taskId',
        bodyData: editTaskModel.toJson(),
      );
      return right(null);
    } on DioException catch (e) {
      log(e.response?.data["message"].toString() ?? e.toString());
      return left(ServerFailure.fromDioException(dioException: e));
    } catch (e) {
      log(e.toString());
      return left(ServerFailure(errMessage: e.toString()));
    }
  }
}
