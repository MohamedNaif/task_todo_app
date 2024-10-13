


import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tasky_todo_app/core/errors/app_errors.dart';
import 'package:tasky_todo_app/core/helper/api_services.dart';
import 'package:tasky_todo_app/core/helper/constant.dart';
import 'package:tasky_todo_app/features/home/data/models/task_model/task_model.dart';
import 'package:tasky_todo_app/features/home/data/repos/task_detailes_repo.dart';

class TaskDetailsRepoImpl implements TaskDetailsRepo {
  final ApiServices _apiServices;

  TaskDetailsRepoImpl(this._apiServices);

  @override
  Future<Either<Failures, TaskModel>> getTaskDetailsData(
      {required String taskId}) async {
    try {
      Response response = await _apiServices.request(
        method: 'GET',
        endPoint: '${EndPoints.todos}/$taskId',
      );
      TaskModel task = TaskModel.fromJson(response.data);
      return right(task);
    } on DioException catch (e) {
      log(e.response?.data["message"].toString() ?? e.toString());
      return left(ServerFailure.fromDioException(dioException: e));
    } catch (e) {
      log(e.toString());
      return left(ServerFailure(errMessage: e.toString()));
    }
  }
}
