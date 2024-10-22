import 'package:flutter_background_sms/src/handlers/sms_action_handler.dart';
import 'package:flutter_background_sms/src/handlers/sms_result_handler.dart';

/// The main class for managing SMS operations.
class FlutterBackgroundSms {
  /// The singleton instance of [FlutterBackgroundSms].
  static final FlutterBackgroundSms _instance = FlutterBackgroundSms._internal();

  /// Returns the singleton instance of [FlutterBackgroundSms].
  static FlutterBackgroundSms get instance => _instance;

  /// Private constructor to ensure the singleton pattern.
  FlutterBackgroundSms._internal();

  /// The handler for SMS actions, managing permissions and SMS services.
  late final SmsActionHandler _smsActionHandler;

  /// Initializes the SMS action handler with dependencies.
  void initialize(SmsActionHandler smsActionHandler) {
    _smsActionHandler = smsActionHandler;
  }

  /// Initializes permissions required for sending SMS.
  Future<void> initializePermissions() async {
    await _smsActionHandler.initializePermissions();
  }

  /// Sends an SMS using the specified parameters.
  ///
  /// [message] The message body to be sent.
  /// [shortCode] is the recipient's shortcode.
  /// [simSlot] specifies the SIM slot to use.
  /// [callback] is the function to handle the result of the SMS action.
  Future<void> sendSms({
    required String shortCode,
    required String message,
    required int simSlot,
    required SmsResultCallback callback,
  }) async {
    try {
      await _smsActionHandler.handleSendSmsAction(
        simSlot: simSlot,
        message: message,
        shortCode: shortCode,
        callBack: callback,
      );
    } catch (e) {
      FormatException('Failed to send SMS: $e');
    }
  }
}
