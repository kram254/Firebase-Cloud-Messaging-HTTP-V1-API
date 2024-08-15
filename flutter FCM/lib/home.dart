import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_notification/main.dart';
import 'package:flutter_notification/product.dart';
import 'package:get/get.dart'; // Added for navigation

class HomePage extends StatefulWidget {
  final String? message;

  HomePage({Key? key, this.message}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    setupInteractedMessage();

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) async {
      RemoteNotification? notification = message?.notification;

      print(notification != null ? notification.title : '');
    });

    FirebaseMessaging.onMessage.listen((message) async {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null && !kIsWeb) {
        String action = jsonEncode(message.data);

        flutterLocalNotificationsPlugin!.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel!.id,
              channel!.name,
              priority: Priority.high,
              importance: Importance.max,
              setAsGroupSummary: true,
              styleInformation: DefaultStyleInformation(true, true),
              largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
              channelShowBadge: true,
              autoCancel: true,
              icon: '@drawable/ic_notifications_icon',
            ),
          ),
          payload: action,
        );
      }
      print('A new event was published!');
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _handleMessage(message.data);
    });
  }

  Future<dynamic> onSelectNotification(payload) async {
    Map<String, dynamic> action = jsonDecode(payload);
    _handleMessage(action);
  }

  Future<void> setupInteractedMessage() async {
    await FirebaseMessaging.instance
        .getInitialMessage()
        .then((value) => _handleMessage(value != null ? value.data : {}));
  }

  void _handleMessage(Map<String, dynamic> data) {
    if (data['redirect'] == "product") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductPage(message: data['message']),
        ),
      );
    } else if (data['redirect'] == "learn_python") {
      Get.toNamed('/other');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You will receive notification',
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/other');
              },
              child: Text('Go to Learn Python Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
