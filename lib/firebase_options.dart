import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// IMPORTANT: Replace these placeholder values with your actual Firebase project configuration.
/// You can get these values from the Firebase Console:
/// 1. Go to Project Settings
/// 2. Select your app
/// 3. Copy the configuration values
///
/// Alternatively, run: flutterfire configure
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
    apiKey: 'AIzaSyDRFyc2dCRSSH5DO5SLdCacsQghhoeE0y0',
    appId: '1:1075933773986:android:f6110866da660b61d497fb',
    messagingSenderId: '1075933773986',
    projectId: 'ay-ecommerce',
    authDomain: 'ay-ecommerce.firebaseapp.com',
    storageBucket: 'ay-ecommerce.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDRFyc2dCRSSH5DO5SLdCacsQghhoeE0y0',
    appId: '1:1075933773986:android:f6110866da660b61d497fb',
    messagingSenderId: '1075933773986',
    projectId: 'ay-ecommerce',
    storageBucket: 'ay-ecommerce.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDRFyc2dCRSSH5DO5SLdCacsQghhoeE0y0',
    appId: '1:1075933773986:android:f6110866da660b61d497fb',
    messagingSenderId: '1075933773986',
    projectId: 'ay-ecommerce',
    storageBucket: 'ay-ecommerce.firebasestorage.app',
    iosBundleId: 'com.ay.laza',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDRFyc2dCRSSH5DO5SLdCacsQghhoeE0y0',
    appId: '1:1075933773986:android:f6110866da660b61d497fb',
    messagingSenderId: '1075933773986',
    projectId: 'ay-ecommerce',
    storageBucket: 'ay-ecommerce.firebasestorage.app',
    iosBundleId: 'com.ay.laza',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDRFyc2dCRSSH5DO5SLdCacsQghhoeE0y0',
    appId: '1:1075933773986:android:f6110866da660b61d497fb',
    messagingSenderId: '1075933773986',
    projectId: 'ay-ecommerce',
    storageBucket: 'ay-ecommerce.firebasestorage.app',
  );
}
