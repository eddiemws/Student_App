import 'package:firebase_core/firebase_core.dart';

Future<void> initializeFirebase() async {
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyC571yV27db1GMX1kl2lkgliVOvKPlWWBc",
      authDomain: "student-app-eaeb4.firebaseapp.com",
      projectId: "student-app-eaeb4",
      storageBucket: "student-app-eaeb4.appspot.com",
      messagingSenderId: "533429540685",
      
