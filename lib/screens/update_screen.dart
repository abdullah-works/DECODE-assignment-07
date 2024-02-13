import 'package:flutter/material.dart';
import 'package:student_registration_app/db/database_helper.dart';
import 'package:student_registration_app/models/student.dart';
import 'package:student_registration_app/utility/data_store.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({
    super.key,
    required this.student,
  });

  final Student student;

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  // @override
  // void initState() {
  //   _selectedCourse = widget.student.course;
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    late String name, email, mobile, selectedCourse, selectedUni;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: widget.student.name,
                decoration: const InputDecoration(
                  hintText: 'Enter your name',
                  label: Text('Name'),
                  border: OutlineInputBorder(),
                ),
                validator: (text) {
                  if (text == null || text.trim().isEmpty) {
                    return 'Please enter your name';
                  }
                  name = text;
                  return null;
                },
              ),
              const SizedBox(height: 8),
              TextFormField(
                initialValue: widget.student.email,
                decoration: const InputDecoration(
                  hintText: 'Enter your email',
                  label: Text('Email'),
                  border: OutlineInputBorder(),
                ),
                validator: (text) {
                  if (text == null || text.trim().isEmpty) {
                    return 'Please enter your email';
                  }
                  final bool emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(text);
                  if (!emailValid) {
                    return 'Please enter a valid email.';
                  }
                  email = text;
                  return null;
                },
              ),
              const SizedBox(height: 8),
              TextFormField(
                initialValue: widget.student.mobile,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Enter your mobile number',
                  label: Text('Mobile'),
                  border: OutlineInputBorder(),
                ),
                validator: (text) {
                  if (text == null || text.trim().isEmpty) {
                    return 'Please enter your mobile number';
                  }

                  final bool mobileValid =
                      RegExp(r"^(?:[+0]3)?[0-9]{11}$").hasMatch(text);
                  if (!mobileValid) {
                    return 'Please enter a valid phone number.';
                  }
                  mobile = text;
                  return null;
                },
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField(
                isExpanded: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Select a course',
                ),
                items: course.map((String item) {
                  return DropdownMenuItem(value: item, child: Text(item));
                }).toList(),
                value: widget.student.course,
                onChanged: (String? value) {
                  selectedCourse = value!;
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a course';
                  }
                  selectedCourse = value;
                  return null;
                },
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField(
                isExpanded: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Select a university'),
                items: university.map((String item) {
                  return DropdownMenuItem(value: item, child: Text(item));
                }).toList(),
                value: widget.student.uni,
                onChanged: (String? value) {
                  selectedUni = value!;
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a university';
                  }
                  selectedUni = value;
                  return null;
                },
              ),
              const SizedBox(height: 14),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      // Update student

                      Student student = Student(
                        id: widget.student.id,
                        name: name,
                        email: email,
                        mobile: mobile,
                        course: selectedCourse,
                        uni: selectedUni,
                      );

                      int result =
                          await DatabaseHelper.instance.updateStudent(student);

                      if (result > 0) {
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   const SnackBar(
                        //       content: Text('SUCCESS: The record is updated.')),
                        // );

                        // Sending (true) to the Student List Screen, So it can
                        // update the UI, by calling setState.
                        Navigator.pop(context, true);
                      } else {
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   const SnackBar(
                        //       content:
                        //           Text('FAILED: The record is not updated.')),
                        // );
                      }
                    }
                  },
                  child: const Text('Update')),
            ],
          ),
        ),
      ),
    );
  }
}
