import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../models/firebase_model.dart';

class FirebaseNotificationService extends GetxService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    // permissions for iOS
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // Initialize local notifications for displaying notifications when the app is in foreground
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');
      final DarwinInitializationSettings initializationSettingsIOS =
          DarwinInitializationSettings();
      final InitializationSettings initializationSettings =
          InitializationSettings(
              android: initializationSettingsAndroid,
              iOS: initializationSettingsIOS);
      await _flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse response) async {
          if (response.payload != null) {
            // Handle notification tapped logic here
          }
        },
      );

      // Handle incoming messages
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        _showNotification(message);
      });

      // Get the token and print it
      String? token = await _firebaseMessaging.getToken();
      if (token != null) {
        print("FCM Token: $token");  // Print the FCM token
        _saveTokenToDatabase(token);
      }

      // Handle token refresh
      _firebaseMessaging.onTokenRefresh.listen((newToken) {
        print("FCM Token Refreshed: $newToken");  // Print the new FCM token
        _saveTokenToDatabase(newToken);
      });
    }
  }

  void _showNotification(RemoteMessage message) {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'default_notification_channel_id',
      'Default',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    _flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title,
      message.notification?.body,
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }

  void _saveTokenToDatabase(String token) {
    // Save the token to your database
    // You can use your existing model and API to save the token
    FirebaseToken firebaseToken = FirebaseToken(token: token);
    // Call your API to save the token
    // Example: await MyApiService.saveToken(firebaseToken);
  }
}




















// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get/get.dart';

// import '../models/firebase_model.dart';

// class FirebaseNotificationService extends GetxService {
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//   final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   Future<void> init() async {
//     // Request permissions for iOS
//     NotificationSettings settings = await _firebaseMessaging.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//     );

//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       // Initialize local notifications for displaying notifications when the app is in foreground
//       const AndroidInitializationSettings initializationSettingsAndroid =
//           AndroidInitializationSettings('@mipmap/ic_launcher');
//       final DarwinInitializationSettings initializationSettingsIOS =
//           DarwinInitializationSettings();
//       final InitializationSettings initializationSettings =
//           InitializationSettings(
//               android: initializationSettingsAndroid,
//               iOS: initializationSettingsIOS);
//       await _flutterLocalNotificationsPlugin.initialize(
//         initializationSettings,
//         onDidReceiveNotificationResponse: (NotificationResponse response) async {
//           if (response.payload != null) {
//             // Handle notification tapped logic here
//           }
//         },
//       );

//       // Handle incoming messages
//       FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//         _showNotification(message);
//       });

//       // Get the token and print it
//       String? token = await _firebaseMessaging.getToken();
//       if (token != null) {
//         print("FCM Token: $token");  // Print the FCM token
//         _saveTokenToDatabase(token);
//       }

//       // Handle token refresh
//       _firebaseMessaging.onTokenRefresh.listen((newToken) {
//         print("FCM Token Refreshed: $newToken");  // Print the new FCM token
//         _saveTokenToDatabase(newToken);
//       });
//     }
//   }

//   void _showNotification(RemoteMessage message) {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//       'default_notification_channel_id',
//       'Default',
//       importance: Importance.max,
//       priority: Priority.high,
//       showWhen: false,
//     );
//     const NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);
//     _flutterLocalNotificationsPlugin.show(
//       0,
//       message.notification?.title,
//       message.notification?.body,
//       platformChannelSpecifics,
//       payload: 'Default_Sound',
//     );
//   }

//   void _saveTokenToDatabase(String token) {
//     // Save the token to your database
//     // You can use your existing model and API to save the token
//     FirebaseToken firebaseToken = FirebaseToken(token: token);
//     // Call your API to save the token
//     // Example: await MyApiService.saveToken(firebaseToken);
//   }
// }
