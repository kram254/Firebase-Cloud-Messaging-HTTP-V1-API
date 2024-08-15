// lib/firebase_options.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform;
import 'package:flutter/foundation.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'your-web-api-key',
    authDomain: 'your-web-auth-domain',
    projectId: 'your-web-project-id',
    storageBucket: 'your-web-storage-bucket',
    messagingSenderId: 'your-web-messaging-sender-id',
    appId: 'your-web-app-id',
    measurementId: 'your-web-measurement-id',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'your-android-api-key',
    authDomain: 'your-android-auth-domain',
    projectId: 'your-android-project-id',
    storageBucket: 'your-android-storage-bucket',
    messagingSenderId: 'your-android-messaging-sender-id',
    appId: 'your-android-app-id',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'your-ios-api-key',
    authDomain: 'your-ios-auth-domain',
    projectId: 'your-ios-project-id',
    storageBucket: 'your-ios-storage-bucket',
    messagingSenderId: 'your-ios-messaging-sender-id',
    appId: 'your-ios-app-id',
    iosBundleId: 'your-ios-bundle-id',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'your-macos-api-key',
    authDomain: 'your-macos-auth-domain',
    projectId: 'your-macos-project-id',
    storageBucket: 'your-macos-storage-bucket',
    messagingSenderId: 'your-macos-messaging-sender-id',
    appId: 'your-macos-app-id',
    iosBundleId: 'your-macos-bundle-id',
  );
}
















// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/foundation.dart';

// static FirebaseOptions get currentPlatform {
//     if (kIsWeb) {
//       return web;
//     }
//     switch (defaultTargetPlatform) {
//       case TargetPlatform.android:
//         return android;
//       case TargetPlatform.iOS:
//         return ios;
//       case TargetPlatform.macOS:
//         return macos;
//       case TargetPlatform.windows:
//         throw UnsupportedError(
//           'DefaultFirebaseOptions have not been configured for windows - '
//           'you can reconfigure this by running the FlutterFire CLI again.',
//         );
//       case TargetPlatform.linux:
//         throw UnsupportedError(
//           'DefaultFirebaseOptions have not been configured for linux - '
//           'you can reconfigure this by running the FlutterFire CLI again.',
//         );
//       default:
//         throw UnsupportedError(
//           'DefaultFirebaseOptions are not supported for this platform.',
//         );
//     }
//   }