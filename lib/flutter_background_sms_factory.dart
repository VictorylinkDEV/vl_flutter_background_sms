import 'package:flutter_background_sms/src/handlers/sms_action_handler.dart';
import 'package:flutter_background_sms/src/services/permission_services/permission_service.dart';
import 'package:flutter_background_sms/src/services/sms_services/sms_service.dart';

import 'flutter_background_sms.dart';

/// A factory class responsible for creating instances of [FlutterBackgroundSms].
///
/// This class encapsulates the creation of the [FlutterBackgroundSms] instance,
/// along with its required dependencies, promoting separation of concerns and
/// better testability in the codebase.
class FlutterBackgroundSmsFactory {
  /// Creates and returns an instance of [FlutterBackgroundSms] with default dependencies.
  ///
  /// This method initializes the necessary services, such as [PermissionService] and
  /// [SmsService], and configures the [SmsActionHandler] to handle SMS actions
  /// appropriately.
  ///
  /// Returns:
  /// An initialized [FlutterBackgroundSms] instance ready for use.
  static FlutterBackgroundSms create() {
    /// Create an instance of the permission service to manage SMS permissions.
    final permissionService = PermissionService();

    /// Create an instance of the SMS service for handling SMS operations.
    final smsService = SmsService();

    /// Initialize the SMS action handler with the created services and handlers.
    final smsActionHandler = SmsActionHandler(
      smsService: smsService,
      permissionService: permissionService,
    );

    /// Get the singleton instance of FlutterBackgroundSms.
    final FlutterBackgroundSms flutterBackgroundSms = FlutterBackgroundSms.instance;

    /// Initialize the flutterBackgroundSms instance with the action handler.
    flutterBackgroundSms.initialize(smsActionHandler);

    /// Return the configured FlutterBackgroundSms instance.
    return flutterBackgroundSms;
  }
}
