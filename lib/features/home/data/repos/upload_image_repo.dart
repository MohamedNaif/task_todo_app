import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:tasky_todo_app/core/errors/app_errors.dart';

abstract class UploadImageRepo {
  Future<Either<Failures, String>> uploadImage({required File imageFile});
}
