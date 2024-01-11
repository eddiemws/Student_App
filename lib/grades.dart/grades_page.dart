//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GradesPage extends StatefulWidget {
  const GradesPage({Key? key}) : super(key: key);

  @override
  State<GradesPage> createState() => _MyAppState();
}

//void initState() {
// super.initState();
//readData(); // Load data when the app starts or the state is initialized
//}
class _MyAppState extends State<GradesPage> {
  final List<String> semesterOptions = [
    '1.1',
    '1.2',
    '1.3',
    '2.1',
    '2.2',
    '2.3',
    '3.1',
    '3.2',
    '3.3',
    '4.1',
    '4.2',
    '4.3',
    '5.1',
    '5.2',
    '5.3',
  ];


  List<Map<String, dynamic>> studentList = [];

  // start of controller for clearing the textformfields//
  TextEditingController semesterController = TextEditingController();
  TextEditingController studentNameController = TextEditingController();
  TextEditingController studentIDController = TextEditingController();
  TextEditingController studyProgramIDController = TextEditingController();
  TextEditingController gpaController = TextEditingController();

  void clearTextFormFields() {
    setState(() {
      //changed //
      semesterController.clear();
      studentNameController.clear();
      studentIDController.clear();
      studyProgramIDController.clear();
      gpaController.clear();
    });
  }

  // End of controller for clearing the textformfields//

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  //changed //
  String studentName = '',
      studentID = '',
      studentSemester = '',
      studyProgramID = '';
  double studentGPA = 00.0;

  String? selectedStudyProgram; // Nullable type
  String? selectedSemester; // Nullable type

  //.......changed //
  getStudentSemester(semester) {
    studentSemester = semester;
  }

  getStudentName(name) {
    studentName = name;
  }

  getStudentID(id) {
    studentID = id;
  }

  getStudyProgramID(programID) {
    studyProgramID = programID;
  }

  getStudentGpa(gpa) {
    studentGPA = double.parse(gpa);
  }

  //create data //

  createData() {
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection("MyStudents")
        .doc(studentName.toLowerCase());

    Map<String, dynamic> students = {
      //.....changed //
      "studentSemester": studentSemester,
      "studentName": studentName,
      "Student ID": studentID,
      "Study Program ID": studyProgramID,
      "GPA": studentGPA,
    };

    documentReference.set(students).whenComplete(() {
      print("$studentName created");
    });
  }

  //read data //

  readData() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection("MyStudents").get();

    setState(
      () {
        studentList = querySnapshot.docs.map((doc) => doc.data()).toList();
      },
    );

    for (QueryDocumentSnapshot<Map<String, dynamic>> doc
        in querySnapshot.docs) {
      //print("Student Name: ${doc.data()['studentName']}");
      //print("Student ID: ${doc.data()['studentID']}");
      //print("Study Program ID: ${doc.data()['studyProgramID']}");
      //print("GPA: ${doc.data()['studentGPA']}");
      print("Student Data: ${doc.data()}");
      //*final studentName = doc.data()['studentName'];
      //*final studentID = doc.data()['studentID'];
      //*final studyProgramID = doc.data()['studyProgramID'];
      //*final studentGPA = doc.data()['studentGPA'];

      //*print("Student Name: $studentName");
      //8print("Student ID: $studentID");
      //*print("Study Program ID: $studyProgramID");
      //*print("GPA: $studentGPA\n");
    }
  }

  //update data //

  updateData() {
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection("MyStudents")
        .doc(studentName.toLowerCase());

    Map<String, dynamic> students = {
      //changed //
      "studentSemester": studentSemester,
      "studentName": studentName,
      "Student ID": studentID,
      "Study Program ID": studyProgramID,
      "GPA": studentGPA,
    };

    documentReference.set(students).whenComplete(() {
      print("$studentName Updated");
    });
  }

  //delete data //

  deleteData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("MyStudents").doc(studentName);

    documentReference.delete().then((_) {
      print("$studentName's data Deleted");
    }).catchError((error) {
      print("Error deleting $studentName's data: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    // Sort the studentList based on studentSemester before using it in the ListView.builder
    studentList.sort((a, b) {
      final semesterA = double.parse(a['studentSemester']);
      final semesterB = double.parse(b['studentSemester']);
      return semesterA.compareTo(semesterB);
    });

    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(10.0),

        // start  for textformfield //
        child: Column(
          children: [
            //semester //
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Semester',
                  labelStyle: TextStyle(
                      color: Colors.redAccent, fontStyle: FontStyle.italic),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
                value: selectedSemester, // Initially selected semester
                onChanged: (String? newValue) {
                  setState(() {
                    selectedSemester = newValue;
                    studentSemester = newValue ?? '';
                    //semesterController.text = newValue ?? '';// Update selected semester
                  });
                },
                items: semesterOptions
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value,
                        style: const TextStyle(
                          color: Colors.orange,
                        )),
                  );
                }).toList(),
              ),
            ),
            // end semester //

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                style: const TextStyle(color: Colors.white),
                controller: studentNameController,
                decoration: const InputDecoration(
                  labelText: 'Subject Name', //student name
                  labelStyle: TextStyle(
                      color: Colors.orangeAccent, fontStyle: FontStyle.italic),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
                onChanged: (String name) {
                  getStudentName(name);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                style: const TextStyle(color: Colors.white),
                controller: studentIDController,
                decoration: const InputDecoration(
                  labelText: 'Grade', //student_ID
                  labelStyle: TextStyle(
                      color: Colors.blue, fontStyle: FontStyle.italic),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
                onChanged: (String id) {
                  getStudentID(id);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                style: const TextStyle(color: Colors.white),
                controller: studyProgramIDController,
                decoration: const InputDecoration(
                  labelText: 'Marks', //study_P.ID
                  labelStyle: TextStyle(
                      color: Colors.green, fontStyle: FontStyle.italic),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
                onChanged: (String studyProgramID) {
                  getStudyProgramID(studyProgramID);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                style: const TextStyle(color: Colors.white),
                controller: gpaController,
                decoration: const InputDecoration(
                  labelText: 'Grade Gpa',
                  labelStyle: TextStyle(
                      color: Colors.green, fontStyle: FontStyle.italic),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
                onChanged: (String gpa) {
                  getStudentGpa(gpa);
                },
              ),
            ),

            // End  for textformfield //

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //create data button //
                    ElevatedButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green),
                      ),
                      onPressed: () {
                        createData();
                        //clear semester pre-selected field after click //
                        selectedSemester = null;
                        semesterController.clear();
                        //clear all the rest formfields after click //
                        clearTextFormFields();
                      },
                      child: const Text('Add Grade'),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    //read data button //
                    ElevatedButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                      ),
                      onPressed: () {
                        readData();
                        //clear semester pre-selected field after click //
                        selectedSemester = null;
                        semesterController.clear();
                        //clear all the rest formfields after click //
                        clearTextFormFields();
                      },
                      child: const Text('Show All'),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    // update data button//
                    ElevatedButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.orange),
                      ),
                      onPressed: () {
                        updateData();
                        //clear semester pre-selected field after click //
                        selectedSemester = null;
                        semesterController.clear();
                        //clear all the rest formfields after click //
                        clearTextFormFields();
                      },
                      child: const Text('Update'),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    //delete data button//
                    ElevatedButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                      ),
                      onPressed: () {
                        deleteData();
                        //clear semester pre-selected field after click //
                        selectedSemester = null;
                        semesterController.clear();
                        //clear all the rest formfields after click //
                        clearTextFormFields();
                      },
                      child: const Text('Delete'),
                    ),
                  ]),
            ),
            const SizedBox(height: 15.0),
            const Text(
              'MY GRADES',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            const SizedBox(height: 15.0),

            // List view starts //
            // before the expanded wraped the list directly without container wite... //
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.blueGrey,
                ),
                child: ListView.builder(
                  itemCount: studentList.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> studentData = studentList[index];
                    if (index == 0 ||
                        studentData['studentSemester'] !=
                            studentList[index - 1]['studentSemester']) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                'Semester ${studentData['studentSemester']}',
                                style: const TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              studentData['studentName'],
                            ),
                            subtitle:
                                Text('Grade: ${studentData['Student ID']}'),
                          ),
                        ],
                      );
                    }

                    return ListTile(
                      title: Text(
                        studentData['studentName'],
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Text('Grade: ${studentData['Student ID']}',
                          style: const TextStyle(color: Colors.white)),
                    );
                  },
                ),
              ),
            ),
            // List view ends
          ],
        ),
      ),
    );
  }
}

//before the two brackets we had this "); for material app//"
