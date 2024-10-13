import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tasky_todo_app/core/errors/app_errors.dart';
import 'package:tasky_todo_app/core/helper/api_services.dart';
import 'package:tasky_todo_app/core/helper/constant.dart';
import 'package:tasky_todo_app/features/home/data/models/task_model/task_model.dart';
import 'package:tasky_todo_app/features/home/data/repos/home_repo.dart';
class HomeRepoImpl implements HomeRepo {
  final ApiServices _apiServices;

  HomeRepoImpl(this._apiServices);

  @override
  Future<Either<Failures, List<TaskModel>>> getAllTasks({required int pageNumber}) async{
    try {
      Response response = await _apiServices.request(
        method: 'GET',
        endPoint: '${EndPoints.todos}?page=$pageNumber',
      );
      if (response.data.isEmpty) return right([]);
      List<TaskModel> todos = [];
      for (var task in response.data) {
        todos.add(TaskModel.fromJson(task));
      }
      return right(todos);
    } on DioException catch (e) {
      log(e.response?.data["message"].toString() ?? e.toString());
      return left(ServerFailure.fromDioException(dioException: e));
    } catch (e) {
      log(e.toString());
      return left(ServerFailure(errMessage: e.toString()));
    }
  }
}
