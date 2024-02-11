// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
    apiKey: 'AIzaSyBR-i_qVZ63gEUin-0bpw0eQWEAdLDh11o',
    appId: '1:953827341499:web:5cabd979e995c36c50e59e',
    messagingSenderId: '953827341499',
    projectId: 'haven-glen',
    authDomain: 'haven-glen.firebaseapp.com',
    storageBucket: 'haven-glen.appspot.com',
    measurementId: 'G-65KVX7C6J8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAhzNhjYSz4XWJNcG39e5QS2dlRaEJUDDQ',
    appId: '1:953827341499:android:b2c62864e3a54ee550e59e',
    messagingSenderId: '953827341499',
    projectId: 'haven-glen',
    storageBucket: 'haven-glen.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCvDdiZW_WR2KtmbiMEDI8_yfRRrR1PxAI',
    appId: '1:953827341499:ios:ff390a27a69d149450e59e',
    messagingSenderId: '953827341499',
    projectId: 'haven-glen',
    storageBucket: 'haven-glen.appspot.com',
    iosBundleId: 'com.example.havenGlen',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCvDdiZW_WR2KtmbiMEDI8_yfRRrR1PxAI',
    appId: '1:953827341499:ios:941937aecd76011a50e59e',
    messagingSenderId: '953827341499',
    projectId: 'haven-glen',
    storageBucket: 'haven-glen.appspot.com',
    iosBundleId: 'com.example.havenGlen.RunnerTests',
  );
}
