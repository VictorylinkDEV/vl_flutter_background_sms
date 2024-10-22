import 'package:flutter/material.dart';
import 'package:flutter_background_sms/flutter_background_sms.dart';
import 'package:flutter_background_sms/flutter_background_sms_factory.dart';

void main() {
  runApp(const SmsHomeScreen());
}

/// The main application widget.
/// The main screen for SMS-related functionality.
/// Displays a button to send SMS and initializes permissions on startup.
class SmsHomeScreen extends StatefulWidget {
  const SmsHomeScreen({super.key});

  @override
  State<SmsHomeScreen> createState() => _SmsHomeScreenState();
}

/// State class for the SmsHomeScreen.
/// Manages the state and interactions within the screen.
class _SmsHomeScreenState extends State<SmsHomeScreen> {
  /// An instance of the service responsible for handling SMS-related operations.
  final FlutterBackgroundSmsService _flutterBackgroundSmsService = FlutterBackgroundSmsService();

  @override
  void initState() {
    super.initState();
    _flutterBackgroundSmsService.initializePermissions(); // Initialize permissions on app start.
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin Example App'), // Displays the title of the app.
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: _flutterBackgroundSmsService.sendSms, // Calls the send SMS method when pressed.
            child: const Text('Send SMS'), // Button text to indicate action.
          ),
        ),
      ),
    );
  }
}



/// A service class that handles SMS sending functionality.
/// It manages the logic for sending SMS using the FlutterBackgroundSms plugin.
class FlutterBackgroundSmsService {
  final FlutterBackgroundSms _flutterSmsPlugin = FlutterBackgroundSmsFactory.create();

  /// Initializes permissions for sending SMS.
  Future<void> initializePermissions() async {
    await _flutterSmsPlugin.initializePermissions();
  }

  /// Sends an SMS using the FlutterBackgroundSms plugin.
  /// This function specifies the recipient's short code, application name, and SIM slot.
  Future<void> sendSms() async {
    await _flutterSmsPlugin.sendSms(
      shortCode: '1234', // The recipient's shortcode.
      message: 'some message', // The message body of the sending SMS.
      simSlot: 0, // The SIM slot to use for sending.
      callback: _handleSmsResult,
    );
  }

  /// Handles the result of the SMS sending action.
  /// It logs the result of the SMS operation for debugging purposes.
  ///
  /// [result]: A map containing the status of the SMS sending operation.
  void _handleSmsResult(Map<String, dynamic> result) {
    print('Result: $result'); // Outputs the result of sending the SMS.
  }
}
