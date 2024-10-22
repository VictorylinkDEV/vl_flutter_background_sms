/// A class responsible for building result maps for SMS sending operations.
class SmsResultHandler {
  /// Constructs a success result map.
  ///
  /// Parameters:
  /// - [message]: The message body sent.
  /// - [status]: The status of the SMS sending attempt.
  ///
  /// Returns:
  /// - A [Map<String, dynamic>] containing the success result.
  Map<String, dynamic> callbackSuccessResult({
    required String message,
    required bool sendingStatus,
  }) {
    return {
      'sendingStatus': sendingStatus,
      'message': message,
    };
  }

  /// Constructs a failure result map.
  ///
  /// Parameters:
  /// - [exception]: The exception thrown during the SMS sending attempt.
  ///
  /// Returns:
  /// - A [Map<String, dynamic>] containing the failure result.
  Map<String, dynamic> callbackFailureResult({
    required Object exception,
    required bool sendingStatus,
  }) {
    return {
      'sendingStatus': sendingStatus,
      'message': 'Failed to send SMS: ${exception.toString()}',
    };
  }
}

/// Callback function type for SMS result handling.
///
/// This callback is invoked with a map containing the result of the SMS
/// sending operation, providing information about the success or failure
/// of the SMS send action.
typedef SmsResultCallback = void Function(Map<String, dynamic> result);
