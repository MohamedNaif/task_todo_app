import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tasky_todo_app/core/errors/app_errors.dart';
import 'package:tasky_todo_app/core/helper/api_services.dart';
import 'package:tasky_todo_app/core/helper/constant.dart';
import 'package:tasky_todo_app/core/helper/shared_pref.dart';
import 'package:tasky_todo_app/features/auth/data/models/auth_info.dart';
import 'package:tasky_todo_app/features/auth/data/models/register_model.dart';
import 'package:tasky_todo_app/features/auth/data/repos/auth_repo.dart';

class AuthRepoImpl implements AuthRepo{
   final ApiServices _apiService;

  AuthRepoImpl(this._apiService);
  @override
 Future<Either<Failures, void>> register(Register model) async {
    try {
      await _apiService.request(
        method: 'POST',
        endPoint: EndPoints.register,
        bodyData: model.toJson(),
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

  // Login User
  @override
  Future<Either<Failures, Authinfo>> login(
      Register model) async {
    try {
      var response = await _apiService.request(
        method: 'POST',
        endPoint: EndPoints.login,
        bodyData: model.toJson(),
      );
      Authinfo data = Authinfo.fromJson(response.data);
      SharedPref.sharedPref.setString(accessToken, data.accessToken!);
      SharedPref.sharedPref.setString(refreshToken, data.refreshToken!);
      return right(data);
    } on DioException catch (e) {
      log(e.response?.data["message"].toString() ?? e.toString());
      return left(ServerFailure.fromDioException(dioException: e));
    } catch (e) {
      log(e.toString());
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  // Logout
  @override
  Future<Either<Failures, void>> logout() async {
    try {
      await _apiService.request(
        method: 'POST',
        endPoint: EndPoints.logout,
      );
      SharedPref.sharedPref.remove(accessToken);
      SharedPref.sharedPref.remove(refreshToken);
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