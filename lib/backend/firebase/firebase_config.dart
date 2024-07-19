import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyBZNwtf7CuIjicD5nGcTTxkn664EuwI0oU",
            authDomain: "creditopopular-da323.firebaseapp.com",
            projectId: "creditopopular-da323",
            storageBucket: "creditopopular-da323.appspot.com",
            messagingSenderId: "336228952544",
            appId: "1:336228952544:web:02866562849b559c406385",
            measurementId: "G-SQ5L6XRYDR"));
  } else {
    await Firebase.initializeApp();
  }
}
