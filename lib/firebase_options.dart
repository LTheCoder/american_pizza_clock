// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
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
    // ignore: missing_enum_constant_in_switch
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB5oLwxJv0GR5p6i6I_IgWac1mIj-dEv0A',
    appId: '1:582380969522:web:b296e49194ddeb5c0be62b',
    messagingSenderId: '582380969522',
    projectId: 'my-app-9b778',
    authDomain: 'my-app-9b778.firebaseapp.com',
    databaseURL: 'https://my-app-9b778-default-rtdb.firebaseio.com',
    storageBucket: 'my-app-9b778.appspot.com',
    measurementId: 'G-L97W3KF62K',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBtVVqjZ75AzTjkSvGjUjhHoyiNory0E9g',
    appId: '1:582380969522:android:0ea620f2de8149740be62b',
    messagingSenderId: '582380969522',
    projectId: 'my-app-9b778',
    databaseURL: 'https://my-app-9b778-default-rtdb.firebaseio.com',
    storageBucket: 'my-app-9b778.appspot.com',
  );
}
