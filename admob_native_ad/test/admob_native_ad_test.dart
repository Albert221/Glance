import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:admob_native_ad/admob_native_ad.dart';

void main() {
  const MethodChannel channel = MethodChannel('admob_native_ad');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await AdmobNativeAd.platformVersion, '42');
  });
}
