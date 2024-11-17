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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBRbyRXJ-ZkORa4NonWIb8VxRlcc3BbnYw',
    appId: '1:167733036320:android:0ddc1a984b2953fa04c345',
    messagingSenderId: '167733036320',
    projectId: 'studify-424cb',
    databaseURL: 'https://studify-424cb-default-rtdb.firebaseio.com',
    storageBucket: 'studify-424cb.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDAecm51tWvVapNPmmU5SxJ92Ouqo2xt84',
    appId: '1:167733036320:ios:a6f0a84f9b6c4a0f04c345',
    messagingSenderId: '167733036320',
    projectId: 'studify-424cb',
    databaseURL: 'https://studify-424cb-default-rtdb.firebaseio.com',
    storageBucket: 'studify-424cb.appspot.com',
    iosClientId: '167733036320-r9471s71aocjo8cu6fkq6pp5rgqe6hqs.apps.googleusercontent.com',
    iosBundleId: 'com.example.studify',
  );
}
