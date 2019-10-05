import 'dart:async';

import 'package:flutter/services.dart';

class AdmobNativeAd {
  static const MethodChannel _channel =
      const MethodChannel('admob_native_ad');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
