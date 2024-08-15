import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:flutter_notification/home.dart';
import 'package:flutter_notification/routes.dart';  // Import the routes file
import 'push_notif_service.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

AndroidNotificationChannel? channel;
FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
late FirebaseMessaging messaging;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void notificationTapBackground(NotificationResponse notificationResponse) {
  print('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    print('notification action tapped with input: ${notificationResponse.input}');
  }

  if (notificationResponse.payload != null) {
    _handleNotificationClick(notificationResponse.payload!);
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  messaging = FirebaseMessaging.instance;

  await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  // Get FCM token and print it
  final fcmToken = await messaging.getToken();
  print("FCM Token: $fcmToken");

  // Get Access Token from the service account
  final accessToken = await PushNotificationService.getAccessToken();
  print("Access Token: $accessToken");

  // Subscribe to a topic
  await messaging.subscribeToTopic('flutter_notification');

  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
        'flutter_notification', // id
        'flutter_notification_title', // title
        importance: Importance.high,
        enableLights: true,
        enableVibration: true,
        showBadge: true,
        playSound: true);

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    final android = AndroidInitializationSettings('@drawable/ic_notifications_icon');
    final iOS = DarwinInitializationSettings();
    final initSettings = InitializationSettings(android: android, iOS: iOS);

    await flutterLocalNotificationsPlugin!.initialize(initSettings,
        onDidReceiveNotificationResponse: notificationTapBackground,
        onDidReceiveBackgroundNotificationResponse: notificationTapBackground);

    await messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Notification',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorKey: navigatorKey,
      initialRoute: '/',
      routes: routes,  // Add routes here
    );
  }
}

void _handleNotificationClick(String payload) {
  // Parse the payload to get the deep link URL
  Uri deepLink = Uri.parse(payload);

  // Use GetX to navigate to the desired screen
  Get.toNamed(deepLink.path, arguments: deepLink.queryParameters);
}






























// import 'dart:async';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_notification/home.dart';
// import 'push_notif_service.dart'; 

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   print('Handling a background message ${message.messageId}');
// }

// AndroidNotificationChannel? channel;
// FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
// late FirebaseMessaging messaging;

// final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// void notificationTapBackground(NotificationResponse notificationResponse) {
//   print('notification(${notificationResponse.id}) action tapped: '
//       '${notificationResponse.actionId} with'
//       ' payload: ${notificationResponse.payload}');
//   if (notificationResponse.input?.isNotEmpty ?? false) {
//     print(
//         'notification action tapped with input: ${notificationResponse.input}');
//   }
// }

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();

//   messaging = FirebaseMessaging.instance;

//   await messaging.requestPermission(
//     alert: true,
//     announcement: false,
//     badge: true,
//     carPlay: false,
//     criticalAlert: false,
//     provisional: false,
//     sound: true,
//   );

//   // Get FCM token and print it
//   final fcmToken = await messaging.getToken();
//   print("FCM Token: $fcmToken");

//   // Get Access Token from the service account
//   final accessToken = await PushNotificationService.getAccessToken();
//   print("Access Token: $accessToken");

//   // Subscribe to a topic
//   await messaging.subscribeToTopic('flutter_notification');

//   // Set the background messaging handler early on, as a named top-level function
//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

//   if (!kIsWeb) {
//     channel = const AndroidNotificationChannel(
//         'flutter_notification', // id
//         'flutter_notification_title', // title
//         importance: Importance.high,
//         enableLights: true,
//         enableVibration: true,
//         showBadge: true,
//         playSound: true);

//     flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

//     final android = AndroidInitializationSettings('@drawable/ic_notifications_icon');
//     final iOS = DarwinInitializationSettings();
//     final initSettings = InitializationSettings(android: android, iOS: iOS);

//     await flutterLocalNotificationsPlugin!.initialize(initSettings,
//         onDidReceiveNotificationResponse: notificationTapBackground,
//         onDidReceiveBackgroundNotificationResponse: notificationTapBackground);

//     await messaging.setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//   }

//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Notification',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       navigatorKey: navigatorKey,
//       home: HomePage(),
//     );
//   }
// }













