import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

import 'package:mime/mime.dart';
import 'package:tasky_todo_app/core/errors/app_errors.dart';
import 'package:tasky_todo_app/core/helper/api_services.dart';
import 'package:tasky_todo_app/core/helper/constant.dart';

import 'upload_image_repo.dart';

class UploadImageRepoImpl implements UploadImageRepo {
  final ApiServices _apiServices;

  UploadImageRepoImpl(this._apiServices);

  @override
  Future<Either<Failures, String>> uploadImage(
      {required File imageFile}) async {
    final String fileName = imageFile.path.split('/').last;
    // Get the MIME type of the file
    final String mimeType = lookupMimeType(imageFile.path) ?? 'image/jpeg';
    final mimeTypeParts = mimeType.split('/');

    final formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(
        imageFile.path,
        filename: fileName,
        contentType: MediaType(mimeTypeParts[0], mimeTypeParts[1]),
      ),
    });

    try {
      final Response response = await _apiServices.request(
        method: 'POST',
        endPoint: EndPoints.uploadImg,
        bodyData: formData,
        contentType: 'multipart/form-data',
      );
      return right(response.data['image']);
    } on DioException catch (e) {
      log("DioException: ${e.response?.data["message"] ?? e.toString()}");
      return left(ServerFailure.fromDioException(dioException: e));
    } catch (e) {
      log("Exception: ${e.toString()}");
      return left(ServerFailure(errMessage: e.toString()));
    }
  }
}
