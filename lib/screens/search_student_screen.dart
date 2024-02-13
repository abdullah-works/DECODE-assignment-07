import 'package:flutter/material.dart';
import 'package:student_registration_app/db/database_helper.dart';
import 'package:student_registration_app/models/student.dart';
import 'package:student_registration_app/screens/update_screen.dart';
import 'package:student_registration_app/widgets/student_card.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SearchStudentScreen extends StatefulWidget {
  const SearchStudentScreen({super.key});

  @override
  State<SearchStudentScreen> createState() => _SearchStudentScreenState();
}

class _SearchStudentScreenState extends State<SearchStudentScreen> {
  late TextEditingController nameC;

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
  void initState() {
    nameC = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Here...'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameC,
              decoration: InputDecoration(
                  hintText: 'Search',
                  suffixIcon: IconButton(
                      onPressed: () {
                        String name = nameC.text.trim();

                        if (name.isEmpty) {
                          // Fluttertoast.showToast(msg: 'Please provide name to search');
                          return;
                        }

                        DatabaseHelper.instance.searchStudents(name);
                        setState(() {});
                      },
                      icon: const Icon(Icons.search))),
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: FutureBuilder<List<Student>>(
                future:
                    DatabaseHelper.instance.searchStudents(nameC.text.trim()),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.isEmpty) {
                      return const Center(
                        child: Text('No students found.'),
                      );
                    }

                    List<Student> students = snapshot.data;

                    return ListView.builder(
                        itemCount: students.length,
                        itemBuilder: (context, index) {
                          Student student = students[index];

                          return StudentCard(
                            studentData: student,
                            onDelete: () {
                              // show alert dialog
                              deleteStudent(student);
                            },
                            onUpdate: () async {
                              bool updated = await Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return UpdateScreen(student: student);
                              }));

                              if (updated) {
                                setState(() {});
                              }
                            },
                          );
                        });
                  } else {
                    return const Center(
                      child: SpinKitSpinningLines(color: Colors.black),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
