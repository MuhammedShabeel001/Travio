import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
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
    apiKey: 'AIzaSyD_KsUbI0BUNDxeQa1ED_KVNNyS9xHE76w',
    appId: '1:579964147879:web:9bb38ae1689fc9c7c66382',
    messagingSenderId: '579964147879',
    projectId: 'travio-df4e8',
    authDomain: 'travio-df4e8.firebaseapp.com',
    storageBucket: 'travio-df4e8.appspot.com',
    measurementId: 'G-4QQCK83K1E',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyACj2mkMUovbnsuysfjTieFVcm0WHXkWEM',
    appId: '1:579964147879:android:7148178b6edc8df8c66382',
    messagingSenderId: '579964147879',
    projectId: 'travio-df4e8',
    storageBucket: 'travio-df4e8.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCgG2UumCyxUN3IWN8MhhTDsYATD_9TZGw',
    appId: '1:579964147879:ios:8b5e70d705ee3436c66382',
    messagingSenderId: '579964147879',
    projectId: 'travio-df4e8',
    storageBucket: 'travio-df4e8.appspot.com',
    iosClientId:
        '579964147879-10qn5t3citfmts4pl7694bcr2kripaca.apps.googleusercontent.com',
    iosBundleId: 'com.example.travio',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCgG2UumCyxUN3IWN8MhhTDsYATD_9TZGw',
    appId: '1:579964147879:ios:8b5e70d705ee3436c66382',
    messagingSenderId: '579964147879',
    projectId: 'travio-df4e8',
    storageBucket: 'travio-df4e8.appspot.com',
    iosClientId:
        '579964147879-10qn5t3citfmts4pl7694bcr2kripaca.apps.googleusercontent.com',
    iosBundleId: 'com.example.travio',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD_KsUbI0BUNDxeQa1ED_KVNNyS9xHE76w',
    appId: '1:579964147879:web:8730c0f3f3c69f14c66382',
    messagingSenderId: '579964147879',
    projectId: 'travio-df4e8',
    authDomain: 'travio-df4e8.firebaseapp.com',
    storageBucket: 'travio-df4e8.appspot.com',
    measurementId: 'G-DQ2TJCNBX0',
  );
}
