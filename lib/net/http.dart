import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:wan_android_flutter/net/interceptor/api_interceptor.dart';
import 'package:wan_android_flutter/net/interceptor/header_interceptor.dart';

final Http http = Http();

class Http extends Dio {
  /*私有构造函数*/
  Http._();

  static Http instance;

  factory Http() {
    if (instance == null) {
      instance = Http._().._init();
    }
    return instance;
  }

  _init() {
    (transformer as DefaultTransformer).jsonDecodeCallback = parseJson;
    interceptors..add(HeaderInterceptor())..add(ApiInterceptor());
  }
}

_parseAndDecode(String response) {
  return jsonDecode(response);
}

parseJson(String text) {
  return compute(_parseAndDecode, text);
}
