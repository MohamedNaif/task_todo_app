


import 'package:dartz/dartz.dart';
import 'package:tasky_todo_app/core/errors/app_errors.dart';
import 'package:tasky_todo_app/features/profile/data/models/user_data.dart';

abstract class ProfileRepo {
  Future<Either<Failures, UserData>> getProfileData();
}
