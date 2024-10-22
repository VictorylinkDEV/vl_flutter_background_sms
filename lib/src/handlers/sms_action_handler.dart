import 'dart:io';

import 'package:flutter_background_sms/src/handlers/sms_result_handler.dart';
import 'package:flutter_background_sms/src/services/permission_services/permission_service.dart';
import 'package:flutter_background_sms/src/services/sms_services/sms_service_interface.dart';

import 'android_sms_permission_handler.dart';

/// Main handler class to orchestrate SMS actions and permissions.
class SmsActionHandler {
  final ISmsService smsService;
  final PermissionService permissionService;

  final AndroidSmsPermissionHandler androidPermissionHandler;

  SmsActionHandler({
    required this.smsService,
    required this.permissionService,
  }) : androidPermissionHandler = AndroidSmsPermissionHandler(
          permissionService: permissionService,
        );

  /// Initializes permissions specifically for Android.
  Future<void> initializePermissions() async {
    if (Platform.isAndroid) {
      await androidPermissionHandler.requestPermissions();
    }
  }

  /// Handles sending SMS based on platform and permissions.
  Future<bool> handleSendSmsAction({
    required int simSlot,
    required String message,
    required String shortCode,
    required SmsResultCallback callBack,
  }) async {
    switch (Platform.operatingSystem) {
      case 'android':
        {
          final bool hasPermission = await androidPermissionHandler.isPermissionGranted();
          if (hasPermission) {
            return await smsService.sendAndroidSms(
              simSlot: simSlot,
              callBack: callBack,
              shortCode: shortCode,
              message: message,
            );
          }
          return false;
        }
      case 'ios':
        await smsService.sendIosSms(
          message: message,
          shortCode: shortCode,
          callBack: callBack,
        );
        return true;
      default:
        return false;
    }
  }
}
