import 'package:firebase_core/firebase_core.dart';

Future<void> initializeFirebase() async {
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyC571yV27db1GMX1kl2lkgliVOvKPlWWBc",
      authDomain: "student-app-eaeb4.firebaseapp.com",
      projectId: "student-app-eaeb4",
      storageBucket: "student-app-eaeb4.appspot.com",
      messagingSenderId: "533429540685",
      appId: "1:533429540685:web:1bfaca8f36deae25f94904",
      measurementId: "G-5LYVKV3XPF",
    ),
  );
}

      
