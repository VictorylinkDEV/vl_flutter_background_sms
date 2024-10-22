import 'dart:io';
import 'package:flutter_background_sms/src/services/permission_services/permission_service.dart';

/// Handles SMS permissions specifically for Android.
class AndroidSmsPermissionHandler {
  final PermissionService permissionService; /// Service for handling permissions.

  /// Creates an instance of [AndroidSmsPermissionHandler].
  ///
  /// Requires [permissionService] for managing SMS permissions.
  AndroidSmsPermissionHandler({
    required this.permissionService,
  });

  /// Requests SMS and phone permissions for Android.
  Future<void> requestPermissions() async {
    if (Platform.isAndroid) {
      await permissionService.requestSmsPermissions(); /// Requests necessary permissions.
    }
  }

  /// Checks if SMS permissions are granted.
  ///
  /// Returns `true` if permissions are granted, otherwise `false`.
  Future<bool> isPermissionGranted() async {
    if (Platform.isAndroid) {
      return await permissionService.isSmsPermissionGranted();
    }
    return false;
  }
}
