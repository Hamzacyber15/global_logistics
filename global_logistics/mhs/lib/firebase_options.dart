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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyD2R7tKuOYiyIQBS7qAXg0baVKwobt_xEg',
    appId: '1:957692951919:web:26f795f30d8f7efa34bc9a',
    messagingSenderId: '957692951919',
    projectId: 'globallogistics-94538',
    authDomain: 'globallogistics-94538.firebaseapp.com',
    storageBucket: 'globallogistics-94538.appspot.com',
    measurementId: 'G-J5LBJZ1311',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAXi9RNCj3T8srQlBBEUe-WIaX9r8t1cC0',
    appId: '1:957692951919:android:b4a12bb4d6571d9f34bc9a',
    messagingSenderId: '957692951919',
    projectId: 'globallogistics-94538',
    storageBucket: 'globallogistics-94538.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyANa_uYOESnpeCbwBooAdt_iEO9VbnJGjE',
    appId: '1:957692951919:ios:b6d1d35d5685bb5534bc9a',
    messagingSenderId: '957692951919',
    projectId: 'globallogistics-94538',
    storageBucket: 'globallogistics-94538.appspot.com',
    iosBundleId: 'com.mhslogistics.app',
  );
}