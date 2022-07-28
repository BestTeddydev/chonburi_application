import 'dart:io';

import 'package:chonburi_mobileapp/constants/api_path.dart';
import 'package:dio/dio.dart';

class DioService {
  static Future<Response<dynamic>> dioPost(String path, dynamic data) async {
    Response response = await Dio().post(
      '${APIRoute.host}$path',
      options: Options(
        headers: {HttpHeaders.contentTypeHeader: "application/json"},
      ),
      data: data,
    );
    return response;
  }

  static Future<Response<dynamic>> dioPostAuthen(
      String path, String token, dynamic data) async {
    Response response = await Dio().post(
      '${APIRoute.host}$path',
      options: Options(
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          'Authorization': 'Bearer $token'
        },
      ),
      data: data,
    );
    return response;
  }

  static Future<Response<dynamic>> dioGetAuthen(
    String path,
    String token,
  ) async {
    Response response = await Dio().get(
      '${APIRoute.host}$path',
      options: Options(
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          'Authorization': 'Bearer $token'
        },
      ),
    );
    return response;
  }

  static Future<Response<dynamic>> dioGet(
    String path,
  ) async {
    Response response = await Dio().get(
      '${APIRoute.host}$path',
      options: Options(
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
      ),
    );
    return response;
  }

  static Future<Response<dynamic>> dioPut(
    String path,
    String token,
    dynamic data,
  ) async {
    Response response = await Dio().put(
      '${APIRoute.host}$path',
      options: Options(
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          'Authorization': 'Bearer $token'
        },
      ),
      data: data,
    );
    return response;
  }

  static Future<Response<dynamic>> dioDelete(
    String path,
    String token,
  ) async {
    Response response = await Dio().delete(
      '${APIRoute.host}$path',
      options: Options(
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          'Authorization': 'Bearer $token'
        },
      ),
    );
    return response;
  }
}
