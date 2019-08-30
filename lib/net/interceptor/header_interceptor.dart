import 'package:dio/dio.dart';
import 'package:wan_android_flutter/utils/log_utils.dart';
import 'package:wan_android_flutter/utils/platform_utils.dart';

class HeaderInterceptor extends InterceptorsWrapper {
  static const String TAG = "HeaderInterceptor";

  @override
  onRequest(RequestOptions options) async {
    options
      ..connectTimeout = 1000 * 30
      ..receiveTimeout = 1000 * 30;

    var appVersion = await PlatformUtils.getAppVersion();
    var version = Map()..addAll({'appVersion': appVersion});
    options
      ..headers['version'] = version
      ..headers['platform'] = PlatformUtils.getPlatform();
    options.headers
        .forEach((k, v) => LogUtils.d(TAG, "key is $k and value is $v"));
    return options;
  }
}
