import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:wan_android_flutter/net/http.dart';
import 'package:wan_android_flutter/utils/log_utils.dart';

class ApiInterceptor extends InterceptorsWrapper {
  static const String TAG = "ApiInterceptor";
  static const baseUrl = 'https://www.wanandroid.com/';

  @override
  onRequest(RequestOptions options) {
    options.baseUrl = baseUrl;
    LogUtils.d(
        TAG,
        'api request url is ${options.baseUrl}${options.path}'
        ' and queryParameters is ${options.queryParameters} ');
    return options;
  }

  @override
  onResponse(Response response) {
    var statusCode = response.statusCode;
    if (statusCode != 200) {
    } else {
      if (response.data is Map) {
        RespData respData = RespData.fromJson(response.data);
        if (respData.success) {
          response.data = respData.data;
          return http.resolve(response);
        } else {
          handleFailed(respData);
        }
      } else {
        LogUtils.d(TAG, "api response error not map $response");
        RespData respData = RespData.fromJson(json.decode(response.data));
        return handleFailed(respData);
      }
    }
  }

  Future<Response> handleFailed(RespData respData) {
    LogUtils.d(TAG, "api response error respData is $respData");
    if (respData.code == -1001) {
      //todo 错误处理
      return null;
    }
    return http.reject(respData.data);
  }
}

class RespData {
  dynamic data;
  int code;

  String message;

  bool get success => 0 == code;

  RespData({this.data, this.code, this.message});

  @override
  String toString() {
    return 'RespData{data: $data, code: $code, message: $message}';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['errorCode'] = this.code;
    data['errorMsg'] = this.message;
    data['data'] = this.data;
    return data;
  }

  RespData.fromJson(Map<String, dynamic> json) {
    code = json['errorCode'];
    message = json['errorMsg'];
    data = json['data'];
  }
}
