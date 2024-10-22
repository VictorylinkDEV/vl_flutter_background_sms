/*
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_background_sms/flutter_background_sms.dart';
import 'package:flutter_background_sms/flutter_background_sms_platform_interface.dart';
import 'package:flutter_background_sms/flutter_background_sms_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterBackgroundSmsPlatform
    with MockPlatformInterfaceMixin
    implements FlutterBackgroundSmsPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterBackgroundSmsPlatform initialPlatform = FlutterBackgroundSmsPlatform.instance;

  test('$MethodChannelFlutterBackgroundSms is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterBackgroundSms>());
  });

  test('getPlatformVersion', () async {
    FlutterBackgroundSms flutterBackgroundSmsPlugin = FlutterBackgroundSms();
    MockFlutterBackgroundSmsPlatform fakePlatform = MockFlutterBackgroundSmsPlatform();
    FlutterBackgroundSmsPlatform.instance = fakePlatform;

    expect(await flutterBackgroundSmsPlugin.getPlatformVersion(), '42');
  });
}
*/
