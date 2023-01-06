import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:trade/network/env.dart';
import 'package:trade/utils/constant.dart';
import 'package:trade/utils/prefs.dart';

final Dio dio = Dio();

late final Dio _dio;

class APIProvider {
  APIProvider() {
    final BaseOptions dioOptions = BaseOptions()..baseUrl = env.baseurl;
    dioOptions.responseType = ResponseType.plain;
    dioOptions.followRedirects = false;
    dioOptions.headers = <String, dynamic>{
      'vAuthorization': 'Bearer ${Prefs.getString(ktoken)}',
      'language': 'en',
      'Accept': 'application/json',
      'cache-control': 'no-cache',
    };
    _dio = Dio(dioOptions);
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioError error, ErrorInterceptorHandler handler) {
          if (error.response?.statusCode == 401) {
            debugPrint('Status Code ===== ${error.response?.statusCode}');
          }
          return handler.next(error);
        },
      ),
    );
  }

  Future<Response<dynamic>> postAPICallWithData(
      String url, dynamic data) async {
    changeHeader();
    final Response<dynamic> response = await _dio.post(url, data: data);
    throwIfNoSuccess(response);
    return response;
  }

  Future<Response<dynamic>> getAPICallWithParameter(
      String url, dynamic parameter) async {
    final Response<dynamic> response =
        await _dio.get(url, queryParameters: parameter);
    throwIfNoSuccess(response);
    return response;
  }

  Future<Response<dynamic>> postAPICall(String url) async {
    final Response<dynamic> response = await _dio.post(url);
    throwIfNoSuccess(response);
    return response;
  }

  Future<Response<dynamic>> getAPICall(String url) async {
    final Response<dynamic> response = await _dio.get(url);
    throwIfNoSuccess(response);
    return response;
  }

  void changeHeader() {
    _dio.options.headers['vAuthorization'] =
        'Bearer ${Prefs.getString(ktoken)}';
    print('Headers');
    print(_dio.options.headers);
  }

  void throwIfNoSuccess(Response<dynamic> response) {
    if (response.statusCode! < 200 || response.statusCode! > 299) {
      throw HttpException(response);
    }
  }
}

class HttpException implements Exception {
  HttpException(this.response);
  Response<dynamic> response;
}
