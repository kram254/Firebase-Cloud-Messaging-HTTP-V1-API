import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:invoix/firebase_options.dart';
import 'package:invoix/models/invoice_data.dart';
import 'package:invoix/pages/main_page.dart';

import 'services/auth.service.dart';
import 'theme.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print('Handling a background message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(InvoiceDataAdapter());
  await Hive.openBox<InvoiceData>('InvoiceData');
  await Hive.openBox<int>('remainingTimeBox');

  await dotenv.load(fileName: ".env");

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  final FirebaseNotificationService notificationService = FirebaseNotificationService();
  await notificationService.init();

  runApp(const ProviderScope(child: InvoicsAiMain()));

  final Box<int> box = Hive.box<int>('remainingTimeBox');
  for (final key in box.keys) {
    int remainingTime = box.get(key) ?? 0;
    if (remainingTime > 0) {
      Timer.periodic(const Duration(seconds: 1), (final t) async {
        remainingTime -= 1;

        if (remainingTime <= 0) {
          remainingTime = 0;
          t.cancel();
        }
        await box.put(key, remainingTime);
      });
    }
  }
}

class InvoicsAiMain extends StatelessWidget {
  const InvoicsAiMain({super.key});

  @override
  Widget build(final BuildContext context) {
    return MaterialApp(
      title: 'invoicsAi',
      theme: const MaterialTheme(TextTheme()).dark().copyWith(
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(150),
          ),
          isDense: true,
          counterStyle: const TextStyle(fontSize: 0),
          errorStyle: const TextStyle(fontSize: 0),
        ),
        listTileTheme: const ListTileThemeData(
          shape: Border.symmetric(
            vertical: BorderSide(color: Colors.white, width: 2.5),
          ),
          titleTextStyle: TextStyle(fontSize: 24),
        ),
        expansionTileTheme: const ExpansionTileThemeData(
          shape: Border.symmetric(
            vertical: BorderSide.none,
          ),
        ),
      ),
      home: const MainPage(),
    );
  }
}



















// import 'dart:async';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:invoix/firebase_options.dart';
// import 'package:invoix/models/invoice_data.dart';
// import 'package:invoix/pages/main_page.dart';

// import 'services/auth.service.dart';
// import 'theme.dart';


// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   print('Handling a background message ${message.messageId}');
// }

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   await Hive.initFlutter();
//   Hive.registerAdapter(InvoiceDataAdapter());
//   await Hive.openBox<InvoiceData>('InvoiceData');
//   await Hive.openBox<int>('remainingTimeBox');

//   await dotenv.load(fileName: ".env");

//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform

//   );


//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

//   final FirebaseNotificationService notificationService = FirebaseNotificationService();
//   await notificationService.init();

//   runApp(const ProviderScope(child: InvoicsAiMain()));

//   final Box<int> box = Hive.box<int>('remainingTimeBox');
//   for (final key in box.keys) {
//     int remainingTime = box.get(key) ?? 0;
//     if (remainingTime > 0) {
//       Timer.periodic(const Duration(seconds: 1), (final t) async {
//         remainingTime -= 1;

//         if (remainingTime <= 0) {
//           remainingTime = 0;
//           t.cancel();
//         }
//         await box.put(key, remainingTime);
//       });
//     }
//   }
// }

// class InvoicsAiMain extends StatelessWidget {
//   const InvoicsAiMain({super.key});

//   @override
//   Widget build(final BuildContext context) {
//     return MaterialApp(
//       title: 'invoicsAi',
//       theme: const MaterialTheme(TextTheme()).dark().copyWith(
//         inputDecorationTheme: InputDecorationTheme(
//           labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(150),
//           ),
//           isDense: true,
//           counterStyle: const TextStyle(fontSize: 0),
//           errorStyle: const TextStyle(fontSize: 0),
//         ),
//         listTileTheme: const ListTileThemeData(
//           shape: Border.symmetric(
//             vertical: BorderSide(color: Colors.white, width: 2.5),
//           ),
//           titleTextStyle: TextStyle(fontSize: 24),
//         ),
//         expansionTileTheme: const ExpansionTileThemeData(
//           shape: Border.symmetric(
//             vertical: BorderSide.none,
//           ),
//         ),
//       ),
//       home: const MainPage(),
//     );
//   }
// }
