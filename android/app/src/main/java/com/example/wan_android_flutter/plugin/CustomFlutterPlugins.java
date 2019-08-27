package com.example.wan_android_flutter.plugin;

import android.util.Log;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;



public class CustomFlutterPlugins {

    private static final String LOG_CHANNEL_NAME = "com.hezhe.wanandroid.plugins/log";
    private static final String LOG_V = "logV";
    private static final String LOG_I = "logI";
    private static final String LOG_D = "logD";
    private static final String LOG_W = "logW";
    private static final String LOG_E = "logE";

    public static void registerLogger(BinaryMessenger messenger) {
        new MethodChannel(messenger, LOG_CHANNEL_NAME).setMethodCallHandler(
                (methodCall, result) -> {
                    String tag = methodCall.argument("tag");
                    String msg = methodCall.argument("msg");
                    switch (methodCall.method) {
                        case LOG_V:
                            Log.v(tag, msg);
                            break;
                        case LOG_I:
                            Log.i(tag, msg);
                            break;
                        case LOG_D:
                            Log.d(tag, msg);
                            break;
                        case LOG_W:
                            Log.w(tag, msg);
                            break;
                        case LOG_E:
                            Log.e(tag, msg);
                            break;
                    }
                });
    }
}
