

import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tasky_todo_app/core/errors/app_errors.dart';
import 'package:tasky_todo_app/core/helper/api_services.dart';
import 'package:tasky_todo_app/core/helper/constant.dart';
import 'package:tasky_todo_app/features/home/data/repos/delete_task_repo.dart';

class DeleteTaskRepoImpl implements DeleteTaskRepo {
  final ApiServices _apiServices;

  DeleteTaskRepoImpl(this._apiServices);

  @override
  Future<Either<Failures, void>> deleteTask({required String taskId}) async {
    try {
      await _apiServices.request(
        method: 'DELETE',
        endPoint: '${EndPoints.todos}/$taskId',
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
