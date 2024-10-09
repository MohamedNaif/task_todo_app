

import 'package:dio/dio.dart';

abstract class Failures {
  final String errMessage;

  Failures({required this.errMessage});
}

class ServerFailure extends Failures {
  ServerFailure({required super.errMessage});

  factory ServerFailure.fromDioException({required DioException dioException}) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(
          errMessage: 'Connection timeout with ApiServer',
        );
      case DioExceptionType.sendTimeout:
        return ServerFailure(
          errMessage: 'Send timeout with ApiServer',
        );
      case DioExceptionType.receiveTimeout:
        return ServerFailure(
          errMessage: 'Receive timeout with ApiServer',
        );
      case DioExceptionType.badCertificate:
        return ServerFailure(
          errMessage: 'badCertificate with ApiServer',
        );
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          statusCode: dioException.response!.statusCode,
          response: dioException.response!.data,
        );
      case DioExceptionType.cancel:
        return ServerFailure(
          errMessage: 'Request to ApiServer was canceled',
        );
      case DioExceptionType.connectionError:
        return ServerFailure(
          errMessage: 'No internet connection, please try again!',
        );
      case DioExceptionType.unknown:
        return ServerFailure(
          errMessage: 'Unexpected error, please try later!',
        );
      default:
        return ServerFailure(
          errMessage: 'Oops there was an error, please try later!',
        );
    }
  }

  factory ServerFailure.fromResponse({int? statusCode, dynamic response}) {
    if (statusCode == 400 ||
        statusCode == 401 ||
        statusCode == 403 ||
        statusCode == 422 ||
        statusCode == 500) {
      return ServerFailure(
        errMessage: response['message'],
      );
    } else if (statusCode == 404) {
      return ServerFailure(
        errMessage: 'Your request not found, please try again',
      );
    } else {
      return ServerFailure(
        errMessage: 'Oops there was an error, please try later!',
      );
    }
  }
}
