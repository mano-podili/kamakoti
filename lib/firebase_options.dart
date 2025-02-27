// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
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
        return windows;
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
    apiKey: 'AIzaSyBG81xzkIQKPOijBQPMgbvcsePZpvCpRv4',
    appId: '1:861943490543:web:786dcc02ead69d4fe3b81a',
    messagingSenderId: '861943490543',
    projectId: 'kamakoti-9dddd',
    authDomain: 'kamakoti-9dddd.firebaseapp.com',
    storageBucket: 'kamakoti-9dddd.appspot.com',
    measurementId: 'G-DPF5MHJHNY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC5dlEcCQGIxEToQSC79X9frpyhZvSE3f0',
    appId: '1:861943490543:android:4315262ac7fc2895e3b81a',
    messagingSenderId: '861943490543',
    projectId: 'kamakoti-9dddd',
    storageBucket: 'kamakoti-9dddd.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDThE6YGCSb_-I_3PNZNpwtB84D2fS4Csg',
    appId: '1:861943490543:ios:93889112f78f8043e3b81a',
    messagingSenderId: '861943490543',
    projectId: 'kamakoti-9dddd',
    storageBucket: 'kamakoti-9dddd.appspot.com',
    iosBundleId: 'com.example.kamakoti',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDThE6YGCSb_-I_3PNZNpwtB84D2fS4Csg',
    appId: '1:861943490543:ios:93889112f78f8043e3b81a',
    messagingSenderId: '861943490543',
    projectId: 'kamakoti-9dddd',
    storageBucket: 'kamakoti-9dddd.appspot.com',
    iosBundleId: 'com.example.kamakoti',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBG81xzkIQKPOijBQPMgbvcsePZpvCpRv4',
    appId: '1:861943490543:web:be039d895e5ecfc5e3b81a',
    messagingSenderId: '861943490543',
    projectId: 'kamakoti-9dddd',
    authDomain: 'kamakoti-9dddd.firebaseapp.com',
    storageBucket: 'kamakoti-9dddd.appspot.com',
    measurementId: 'G-4PE93MXT8S',
  );
}
