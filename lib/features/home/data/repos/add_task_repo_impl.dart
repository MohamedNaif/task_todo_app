import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tasky_todo_app/core/errors/app_errors.dart';
import 'package:tasky_todo_app/core/helper/api_services.dart';
import 'package:tasky_todo_app/core/helper/constant.dart';
import 'package:tasky_todo_app/features/home/data/models/add_task_model.dart';
import 'package:tasky_todo_app/features/home/data/repos/add_task_repo.dart';

class AddTaskRepoImpl implements AddTaskRepo {
  final ApiServices _apiServices;

  AddTaskRepoImpl(this._apiServices);
  @override
  Future<Either<Failures, void>> addTask(
      {required AddTaskModel addTaskModel}) async {
    try {
      await _apiServices.request(
        method: 'POST',
        endPoint: EndPoints.todos,
        bodyData: addTaskModel.toJson(),
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
