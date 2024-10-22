# flutter_background_sms 
## High Level Flow 

A flutter_background_sms plugin for sending SMS in the background for mobile number verification with only one click.

Prerequisite:
*  Communicate with Victory link team to reserve short number.
*  Backend URL to receive the message sent from your mobile app(feel free to send plain or encrypt body between your mobile app and your backend)

Contact details:

plugin inputs parameter from mobile app developer:
*  [message] The message body that will be sent from your app though flutter_background_sms to short code then to your backend
*  [shortCode] reserve shortcode number bought from Victorylik.
*  [simSlot] specifies the SIM slot index that will be used in verification process.
*  [callback] is the function to handle the result of client send the SMS.

In case Android:
Then Plugin Based on the received parameter, SMS will be sent automatically containing the message body received from mobile app based on selected SIM slot to the reserved shortcode number and return back to the call back method that sent in input parameters.

In case IOS:
Then Plugin Based on the received parameter, will open the native SMS app containing the message body received from mobile app as client will only click send this content based on selected SIM slot to the reserved shortcode number and return back to the call back method that sent over input parameters.

then mobile mobile app should receive message sending status so that mobile app developer could call it backend ofr the needed verification


## Technical Details

1.Introduction	
The Content-Based Verification plugin simplifies integrating SMS functionality into Flutter apps, especially for those using short codes. It abstracts platform differences, allowing background SMS sending while you focus on core app features. Using short codes, this plugin helps reduce overall costs, particularly for international SMS and OTPs, minimizing waste and ensuring that the end users of your app carry the expenses.


1.1Scope of Work	
The primary focus of this solution is to optimize the costs associated with SMS communication for businesses. By using short codes, it helps to significantly reduce the expenses of international SMS and OTP services, ensuring that messages are delivered efficiently without unnecessary spending. Additionally, it minimizes the wastage of SMS resources, allowing businesses to manage their communication budget more effectively. The approach also shifts the cost burden to the end users of the app, ensuring that businesses can maintain a sustainable and cost-effective communication strategy while delivering value to their customers.

2. Purpose of the Plugin
The Flutter Background SMS plugin simplifies the integration of SMS functionality in Flutter apps, helping developers navigate platform-specific complexities. It is designed to:
1.	Cross-Platform Support: Enables a single codebase to handle SMS across both Android and iOS, reducing the need for custom implementations.

2.	Easy Permissions Management: Streamlines the process of obtaining SMS permissions, improving user experience and compliance.

3.	User-Friendly Integration: Allows developers to add SMS features without needing deep native code knowledge.

4.	Focus on Speed: Speeds up development, helping teams quickly implement SMS-based features like 2FA and notifications.
3. Core Capabilities
Key features of the plugin include:
•	Android SMS: Directly sends messages through specified SIM slots, ideal for dual-SIM management.

•	iOS SMS: Launches the native SMS app with pre-filled messages, ensuring user interaction and data security.

•	Status Callbacks: Provides real-time updates on SMS status, enabling better error handling.

•	Unified Codebase: Reduces the need for platform-specific adjustments, making SMS integration easier.

4.Plugin Diagram

•  Initialization: When the user opens the app, the initState() method is triggered to initialize permissions. The Flutter Background SMS plugin handles permission requests through the SMS Handler, which interacts with platform-specific handlers (Android or iOS).
•  Permission Handling: If the platform is Android, the Android SMS Permission Handler checks for required SMS permissions through the Permission Service and returns the status (Granted or Denied). If the platform is iOS, permissions are managed directly by the system when the user attempts to send an SMS.
•  SMS Sending:
•	Android: If permissions are granted, the sendAndroidSms() method is invoked, and the message is sent directly.

•	iOS: The sendIOSSms() method launches the iOS Messages app with a pre-filled message body.

•	Status Feedback: The user is notified about the success or failure of the SMS sending process through the app interface.


![image](https://github.com/user-attachments/assets/5da97df9-4867-464d-b7e6-88a1609232f7)


5.Code Explanation…
The Flutter Background SMS plugin is structured to provide a clean, organized, and modular approach to SMS handling in Flutter applications. Here’s a detailed explanation of the key components, their structure, and functionalities included in the codebase:
5.1Plugin Structure:
The plugin follows a layered architecture, separating concerns into distinct modules for services, handlers, and utilities. This modularity ensures that each component can be developed, tested, and maintained independently.
5.1.1Core Classes:
•	ISmsService: This interface defines the core functionalities for sending SMS messages on different platforms (Android and iOS). Implementing this interface allows for flexibility and extensibility, making it easy to add support for new platforms in the future.

![image](https://github.com/user-attachments/assets/735f3e66-54be-4c3b-95a3-a3c9754f7ba5)

•	SmsService: This class implements the ISmsService interface. It handles the actual SMS-sending logic for both Android and iOS platforms. It utilizes method channels to communicate with native code for sending SMS on Android and launches the iOS SMS application.

![image](https://github.com/user-attachments/assets/fb0c5c19-800e-4958-81fc-e7004c80c9d2)

•	SmsActionHandler: This class orchestrates SMS operations and manages permission requests. It utilizes platform-specific handlers (like AndroidSmsPermissionHandler) to encapsulate permissions and SMS sending logic, adhering to the Single Responsibility Principle.

![image](https://github.com/user-attachments/assets/a51e8812-5d4a-4342-8223-eab86e326adb)

5.1.2Permission Management:
•	PermissionService: This service handles permission requests for SMS access. It ensures that permissions are requested appropriately, preventing multiple simultaneous requests, and checks if permissions are granted.

![image](https://github.com/user-attachments/assets/3df3ae26-9212-42d5-8bf9-db27b04b85b6)

•	AndroidSmsPermissionHandler: A specialized class that handles SMS permission requests specifically for Android. It abstracts the permission logic, allowing the SmsActionHandler to focus on higher-level SMS functionalities.

![image](https://github.com/user-attachments/assets/686a8265-347d-42cd-a4d7-7c9baf18a5c5)

5.1.3Callback Mechanism:
•	The plugin utilizes callback functions (defined by SmsResultCallback) to notify developers of SMS operation results. This asynchronous pattern allows developers to handle success and failure scenarios effectively.

![image](https://github.com/user-attachments/assets/66633ec1-a2ab-45e9-a1fb-42c05c95339f)

5.1.4Factory Design Pattern:
•	FlutterBackgroundSmsFactory: This factory class simplifies the creation of plugin instances, encapsulating the setup of dependencies like SmsService and PermissionService. This design pattern promotes loose coupling and enhances testability.

![image](https://github.com/user-attachments/assets/a56b22c3-6bb6-49d0-8411-02f8a45887a9)

5.1.5Singleton Design Pattern:
•	FlutterBackgroundSms: This class follows the Singleton pattern, ensuring there is only one instance of the SMS handler throughout the application. By providing a static instance accessible globally, it simplifies the management of SMS operations and their dependencies, allowing the plugin to maintain a consistent state and configuration across different parts of the application.

![image](https://github.com/user-attachments/assets/0caf46d7-0561-4eaf-9303-2d754688ebec)

6.Example of Usage	
Integrating the Flutter Background SMS plugin into your Flutter application is straightforward. Below is a step-by-step guide on how to set up and use the plugin for sending SMS messages.

Step 1: Add Android Permissions:
First, add uses-Permissions to your AndroidManifest.xml file:

![image](https://github.com/user-attachments/assets/46011825-faa0-4d96-92bf-8d4cc5e08d40)

Step 2: Add Dependency:
Add the plugin to your pubspec.yaml file:

![image](https://github.com/user-attachments/assets/bf90968d-df4c-4def-b1a5-ba50404c9584)

Make sure to run flutter pub get to install the package.

Step 3: Import the Plugin:
In your Dart file, import the plugin:

![image](https://github.com/user-attachments/assets/ff5b5c1c-cc9e-4b8a-9fb2-e9d8073a114a)

![image](https://github.com/user-attachments/assets/a4d56075-c386-4cd2-965e-b8c161726df2)

Step 4: Initialize the Plugin and Request Permissions:

Before sending SMS messages, initialize the plugin. You can do this in your main function or your app's initialization logic:

![image](https://github.com/user-attachments/assets/085437e2-255a-47d9-9795-f01dc78f2dfd)

Step 5: Send SMS:
To send an SMS message, use the FlutterBackgroundSms class. Here’s how you can send an SMS using the plugin: 

![image](https://github.com/user-attachments/assets/50bddd9e-9467-4a5a-ab39-a8169f7f0c40)

![image](https://github.com/user-attachments/assets/9cb7af03-53e1-42db-90e1-bce8f697d7b8)


Step 6: Handling Results
The callback function in the sendSms method provides a result map, which contains the status of the SMS operation and a sent message body. You can use this information to manage the results effectively in your application.


7.Conclusion

The Flutter Background SMS plugin is an invaluable tool for businesses looking to integrate SMS functionality into their Flutter applications. By providing a clean interface for sending SMS messages across Android and iOS, the plugin removes technical complexities, allowing businesses to focus on what matters most: delivering value to their users. By leveraging this plugin, businesses can reduce the costs associated with international messaging and OTP services through the use of shortcodes, ensuring efficient communication while minimizing expenses. Its adherence to SOLID and OOP principles ensures that the codebase remains maintainable and adaptable to changing needs, making it a robust choice for any business looking to scale its communication capabilities.













