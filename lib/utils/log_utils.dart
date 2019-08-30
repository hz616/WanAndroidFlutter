import 'package:flutter/services.dart';

class LogUtils {
  LogUtils._();

  static const _platform =
      const MethodChannel('com.hezhe.wanandroid.plugins/log');

  static void i(String tag, String msg) {
    _platform.invokeMethod('logI', {'tag': tag, 'msg': msg});
  }

  static void d(String tag, String msg) {
    _platform.invokeMethod('logD', {'tag': tag, 'msg': msg});
  }

  static void v(String tag, String msg) {
    _platform.invokeMethod('logV', {'tag': tag, 'msg': msg});
  }

  static void w(String tag, String msg) {
    _platform.invokeMethod('logW', {'tag': tag, 'msg': msg});
  }

  static void e(String tag, String msg) {
    _platform.invokeMethod('logE', {'tag': tag, 'msg': msg});
  }
}
