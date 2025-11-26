// File: lib/firebase_options.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
      apiKey: "AIzaSyBVzNfclZczaDy3uOhaCn1T7XvtoXznJ-k",
      authDomain: "i-gestion-6a0f5.firebaseapp.com",
      projectId: "i-gestion-6a0f5",
      storageBucket: "i-gestion-6a0f5.firebasestorage.app",
      messagingSenderId: "678461467392",
      appId: "1:678461467392:web:f49a77eca7741727b7a1e5",
      measurementId: "G-965YSWDTY9");

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA3r9Xq3Xq3Xq3Xq3Xq3Xq3Xq3Xq3Xq3Xq3Xq3',
    appId: '1:1234567890:web:1234567890',
    messagingSenderId: '1234567890',
    projectId: 'i-gestion-project',
    storageBucket: 'i-gestion-project.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA3r9Xq3Xq3Xq3Xq3Xq3Xq3Xq3Xq3Xq3Xq3Xq3',
    appId: '1:1234567890:ios:1234567890',
    messagingSenderId: '1234567890',
    projectId: 'i-gestion-project',
    storageBucket: 'i-gestion-project.appspot.com',
    iosBundleId: 'com.example.iGestion',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA3r9Xq3Xq3Xq3Xq3Xq3Xq3Xq3Xq3Xq3Xq3Xq3',
    appId: '1:1234567890:ios:1234567890',
    messagingSenderId: '1234567890',
    projectId: 'i-gestion-project',
    storageBucket: 'i-gestion-project.appspot.com',
    iosBundleId: 'com.example.iGestion',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBVzNfclZczaDy3uOhaCn1T7XvtoXznJ-k',
    appId: '1:678461467392:web:f49a77eca7741727b7a1e5',
    messagingSenderId: '678461467392',
    projectId: 'i-gestion-6a0f5',
    authDomain: 'i-gestion-6a0f5.firebaseapp.com',
    storageBucket: 'i-gestion-6a0f5.firebasestorage.apps',
  );
}
