



import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:tasky_todo_app/core/helper/constant.dart';
import 'package:tasky_todo_app/core/helper/shared_pref.dart';

class ApiServices {
  final Dio _dio;
  final String _baseUrl = 'https://todo.iraqsapp.com';

  ApiServices(this._dio);

  //Request Methods (POST, GET, PUT, DELETE)
  Future<Response> request({
    required String method,
    required String endPoint,
    Object? bodyData,
    String contentType = 'application/json',
  }) async {
    String token = await _getToken();
    Response response = await _dio.request(
      '$_baseUrl/$endPoint',
      options: Options(
        method: method,
        headers: {
          'Content-Type': contentType,
          'Authorization': 'Bearer $token',
        },
      ),
      data: bodyData,
    );

    return response;
  }

  //Get Token
  Future<String> _getToken() async {
    final token = SharedPref.sharedPref.getString(accessToken);
    if (token == null) return '';

    if (JwtDecoder.isExpired(token)) {
      return await _refreshToken();
    }
    return token;
  }

  //Refresh Token
  Future<String> _refreshToken() async {
    try {
      final refreshToken = SharedPref.sharedPref.getString('refreshToken')!;
      final response = await _dio.get(
        '$_baseUrl/${EndPoints.refreshToken}?token=$refreshToken',
      );
      final newToken = response.data['access_token'];
      SharedPref.sharedPref.setString(accessToken, newToken);
      return newToken;
    } on DioException catch (e) {
      log(e.response?.data["message"].toString() ?? e.toString());
    } catch (e) {
      log(e.toString());
    }
    return '';
  }
}
