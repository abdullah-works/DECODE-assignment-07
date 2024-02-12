import 'package:flutter/material.dart';
import 'package:student_registration_app/db/database_helper.dart';
import 'package:student_registration_app/models/student.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:student_registration_app/widgets/student_card.dart';

class StudentListScreen extends StatefulWidget {
  const StudentListScreen({super.key});

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
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
                  // return const SearchStudentScreen();
                  return const Placeholder();
                }));
              },
              icon: const Icon(Icons.search)),
        ],
      ),
      body: FutureBuilder(
          future: DatabaseHelper.instance.getAllStudents(),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return const Center(
                  child: Text('Nothing here. Try adding some enteries.'),
                );
              }

              List<Student> students = snapshot.data!;

              return ListView.builder(
                  itemCount: students.length,
                  itemBuilder: ((context, index) {
                    Student student = students[index];
                    return StudentCard(studentData: student);
                  }));
            }
            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong.'));
            }

            return const SpinKitSpinningLines(color: Colors.black);
          })),
    );
  }
}
