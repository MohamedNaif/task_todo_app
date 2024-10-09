import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tasky_todo_app/core/errors/app_errors.dart';
import 'package:tasky_todo_app/core/helper/api_services.dart';
import 'package:tasky_todo_app/core/helper/constant.dart';
import 'package:tasky_todo_app/features/profile/data/models/user_data.dart';
import 'package:tasky_todo_app/features/profile/data/repos/profile_repo.dart';

class ProfileRepoImpl implements ProfileRepo {
  final ApiServices _apiServices;

  ProfileRepoImpl(this._apiServices);
  @override
  Future<Either<Failures, UserData>> getProfileData()async {
   
    try {
      Response response = await _apiServices.request(
        method: 'GET',
        endPoint: EndPoints.profile,
      );
      var userData = UserData.fromJson(response.data);
      return right(userData);
    } on DioException catch (e) {
      log(e.response?.data["message"].toString() ?? e.toString());
      return left(ServerFailure.fromDioException(dioException: e));
    } catch (e) {
      log(e.toString());
      return left(ServerFailure(errMessage: e.toString()));
    }
  }
}
