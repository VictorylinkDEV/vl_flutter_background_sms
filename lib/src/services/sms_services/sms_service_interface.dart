import 'package:flutter_background_sms/src/handlers/sms_result_handler.dart';

/// Interface defining the SMS service functionalities.
///
/// Implementations of this interface must provide methods for sending SMS
/// on different platforms (Android and iOS). This allows for easy extension
/// and testing of SMS services without tightly coupling the implementation
/// details to the interface.
abstract class ISmsService {
  /// Sends an SMS message on Android devices.
  ///
  /// Parameters:
  /// - [simSlot]: The SIM slot to use for sending the SMS (0 for SIM1, 1 for SIM2).
  /// - [callBack]: A callback function that receives the result of the SMS sending operation.
  /// - [shortCode]: The recipient's shortcode to which the SMS will be sent.
  /// - [message]: The message body to be sent.
  ///
  /// Returns:
  /// A [Future<bool>] indicating whether the SMS was sent successfully.
  Future<bool> sendAndroidSms({
    required int simSlot,
    required SmsResultCallback callBack,
    required String shortCode,
    required String message,
  });

  /// Sends an SMS message on iOS devices.
  ///
  /// Parameters:
  /// - [callBack]: A callback function that receives the result of the SMS sending operation.
  /// - [shortCode]: The recipient's shortcode to which the SMS will be sent.
  /// - [message]: The message body to be sent.
  ///
  /// Returns:
  /// A [Future<void>] indicating the completion of the SMS sending operation.
  Future<void> sendIosSms({
    required SmsResultCallback callBack, /// Callback function with result map
    required String shortCode,
    required String message,
  });
}


