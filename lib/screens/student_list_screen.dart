import 'package:flutter/material.dart';
import 'package:student_registration_app/db/database_helper.dart';
import 'package:student_registration_app/models/student.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:student_registration_app/screens/search_student_screen.dart';
import 'package:student_registration_app/screens/update_screen.dart';
import 'package:student_registration_app/widgets/student_card.dart';

class StudentListScreen extends StatefulWidget {
  const StudentListScreen({super.key});

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  void deleteStudent(Student student) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Confirmation'),
            content: const Text('Are you sure to delete ? '),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('No')),
              TextButton(
                  onPressed: () async {
                    Navigator.pop(context);

                    int result = await DatabaseHelper.instance
                        .deleteStudent(student.id!);

                    if (result > 0) {
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   const SnackBar(
                      //       content: Text('SUCCESS: The record is deleted.')),
                      // );
                      setState(() {});
                    } else {
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   const SnackBar(
                      //       content:
                      //           Text('FAILED: The record is not deleted.')),
                      // );
                    }
                  },
                  child: const Text('Yes')),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student List'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const SearchStudentScreen();
                }));
              },
              icon: const Icon(Icons.search)),
        ],
      ),
      body: FutureBuilder(
          future: DatabaseHelper.instance.getAllStudents(),
          builder: ((BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return const Center(
                  child: Text('No student here. Try adding some.'),
                );
              }

              // otherwise, it has data, So,
              List<Student> students = snapshot.data!;

              return ListView.builder(
                  itemCount: students.length,
                  itemBuilder: ((context, index) {
                    Student student = students[index];

                    return StudentCard(
                      studentData: student,
                      onDelete: () {
                        // Show Alert Dialog
                        deleteStudent(student);
                      },
                      onUpdate: () async {
                        // Go to Update Screen
                        bool? updated = await Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return UpdateScreen(student: student);
                        }));

                        // Because, maybe the user comes back from that screen
                        // without updating the Student, So, updated will be null
                        if (updated == null) {
                          return;
                        }
                        setState(() {});
                      },
                    );
                  }));
            }
            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong.'));
            }
            // No need to write else.
            // else
            return const SpinKitSpinningLines(color: Colors.black);
          })),
    );
  }
}
