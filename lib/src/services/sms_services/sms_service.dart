import 'package:flutter/services.dart';
import 'package:flutter_background_sms/src/handlers/sms_result_handler.dart';
import 'package:flutter_background_sms/src/services/sms_services/sms_sender_service.dart';
import 'package:flutter_background_sms/src/services/sms_services/sms_service_interface.dart';

/// A service class responsible for sending SMS messages on both Android and iOS platforms.
class SmsService implements ISmsService {
  /// Reference to the method channel for sending SMS.
  static const platform = MethodChannel('SEND_SMS_METHOD_CHANNEL');

  final SmsSender _smsSender;
  final SmsResultHandler _resultHandler;

  /// Constructs an instance of [SmsService].
  ///
  /// Initializes the [SmsSender], and [SmsResultHandler] services.
  SmsService()
      : _smsSender = SmsSender(),
        _resultHandler = SmsResultHandler();

  /// Sends an SMS message via Android.
  ///
  /// Takes the necessary parameters to send an SMS and notifies the developer
  /// of the result through the provided callback.
  ///
  /// Parameters:
  /// - [simSlot]: The SIM slot to use for sending the SMS (0 for SIM1, 1 for SIM2).
  /// - [callBack]: A callback function that receives a map with the result of the SMS sending attempt.
  /// - [shortCode]: The recipient's phone number or shortcode to which the SMS will be sent.
  /// - [message]: The message body to be sent.
  ///
  /// Returns:
  /// - A [Future] that resolves to a [bool], indicating whether the SMS was sent successfully.
  @override
  Future<bool> sendAndroidSms({
    required int simSlot,
    required SmsResultCallback callBack,
    required String shortCode,
    required String message,
  }) async {
    try {
      /// Send the SMS using the specified SIM slot.
      final bool result = await _smsSender.sendAndroidSms(
        message: message,
        simSlot: simSlot,
        shortCode: shortCode,
      );

      /// Notify the developer using the success result map.
      final callbackSuccessResult =
          _resultHandler.callbackSuccessResult(message: message, sendingStatus: result);
      callBack(callbackSuccessResult);
      return result;
    } catch (e) {
      /// Notify the developer using the failure result map.
      final callbackFailureResult = _resultHandler.callbackFailureResult(sendingStatus: false, exception: e);
      callBack(callbackFailureResult);
      return false;
    }
  }

  /// Sends an SMS message via iOS.
  ///
  /// Takes the necessary parameters to send an SMS and notifies the developer
  /// of the result through the provided callback.
  ///
  /// Parameters:
  /// - [callBack]: A callback function that receives a map with the result of the SMS sending attempt.
  /// - [shortCode]: The recipient's phone number or shortcode to which the SMS will be sent.
  /// - [message]: The message body to be sent.
  ///
  /// Returns:
  /// - A [Future] that resolves to void.
  @override
  Future<void> sendIosSms({
    required SmsResultCallback callBack,
    required String shortCode,
    required String message,
  }) async {
    try {
      /// Launch the iOS SMS app with the prepared message.
      await _smsSender.launchIosSmsApp(message, shortCode);

      /// Notify the developer using the success result map.
      final callbackSuccessResult =
          _resultHandler.callbackSuccessResult(message: message, sendingStatus: true);
      callBack(callbackSuccessResult); // Assuming SMS launch is successful
    } catch (e) {
      /// Notify the developer using the failure result map.
      final callbackFailureResult = _resultHandler.callbackFailureResult(exception: e, sendingStatus: false);
      callBack(callbackFailureResult);
    }
  }
}
