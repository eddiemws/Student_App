import 'package:flutter/material.dart';
import 'package:student_app/assignment/assignments_page.dart';
import 'package:student_app/calendar/calendars_page.dart';
import 'package:student_app/dashboard/dashboards_Page.dart';

import 'package:student_app/grades.dart/grades_page.dart';
import 'package:firebase_core/firebase_core.dart';

//import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
  ); // Initialize Firebase
  //const app = initializeApp(firebaseConfig);
//const analytics = getAnalytics(app);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> cardNames = [
      'Dashboard',
      'Assignment',
      'Calendar',
      'Grades'
    ];
    final List<IconData> cardIcons = [
      Icons.settings_accessibility_rounded,
      Icons.book_outlined,
      Icons.calendar_today,
      Icons.school_outlined,
    ];

    final List<String> cardImages = [
      'images/icon6.jpg',
      'images/icon3.jpg',
      'images/icon4.jpg',
      'images/icon7.jpeg',
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 7, 8, 10),
        body: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text('Hello Eddie',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          )),
                    ),
                    CircleAvatar(
                      backgroundImage: AssetImage('images/passport1-photo.jpg'),
                      radius: 20.0,
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                padding: const EdgeInsets.all(16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.asset(
                    'images/icon8.jpg',
                    fit: BoxFit.cover,
                    height: 230,
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(35.0),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 20.0,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        navigateToPage(context, index);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        //grid card starts: contents= column and row inside that column.//
                        child: Card(
                          color: Colors.black,
                          elevation: 8.0,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    cardIcons[index],
                                    size: Checkbox.width,
                                    color: Colors.white,
                                  ),
                                  const Spacer(),
                                  Text(
                                    cardNames[index],
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(30.0),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Image.asset(
                                    cardImages[index],
                                  ),
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                        //grid card ends//
                      ),
                    );
                  },
                  childCount: cardNames.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void navigateToPage(BuildContext context, int index) {
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  DashboardsPage()),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AssignmentsPage()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CalendarsPage()),
      );
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const GradesPage()),
      );
    }
  }
}
