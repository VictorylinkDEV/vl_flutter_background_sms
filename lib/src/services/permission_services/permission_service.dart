import 'package:permission_handler/permission_handler.dart';

/// The PermissionService class manages permission requests for SMS and phone access.
///
/// This class is responsible for requesting necessary permissions and checking
/// their status. It ensures that multiple requests for permissions are not
/// made concurrently, adhering to the Single Responsibility Principle (SRP).
class PermissionService {
  bool _isRequestingPermissions = false; /// Flag to track if a permission request is in progress

  /// Requests SMS and phone permissions from the user.
  ///
  /// This method initiates a request for SMS permissions using the
  /// permission_handler package. It prevents multiple concurrent requests
  /// to ensure a smooth user experience.
  Future<void> requestSmsPermissions() async {
    if (_isRequestingPermissions) {
      return; /// Prevents multiple concurrent requests.
    }
    _isRequestingPermissions = true; /// Set flag to indicate a request is in progress

    try {
      await [
        Permission.sms,
        Permission.phone,
      ].request(); /// Request SMS permissions
    } finally {
      _isRequestingPermissions = false; /// Reset the flag when done.
    }
  }

  /// Checks if SMS permission is granted.
  ///
  /// This method verifies if the SMS permission has been granted by the user.
  /// It checks the current status and returns true if granted, false otherwise.
  ///
  /// Returns:
  /// A [Future<bool>] indicating whether SMS permission is granted.
  Future<bool> isSmsPermissionGranted() async {
    final PermissionStatus smsStatus = await Permission.sms.status; /// Get the current SMS permission status
    return smsStatus.isGranted; /// Return true if SMS permission is granted
  }
}
