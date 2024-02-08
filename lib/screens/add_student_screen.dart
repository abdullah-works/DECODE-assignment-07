import 'package:flutter/material.dart';
import 'package:student_registration_app/db/database_helper.dart';
import 'package:student_registration_app/models/student.dart';
import 'package:student_registration_app/utility/data_store.dart';

class AddStudentScreen extends StatelessWidget {
  const AddStudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    late String name, email, mobile;
    String? selectedCourse;
    String? selectedUni;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Student'),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              TextFormField(
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
                decoration: const InputDecoration(
                  hintText: 'Enter your email',
                  label: Text('Email'),
                  border: OutlineInputBorder(),
                ),
                validator: (text) {
                  if (text == null || text.trim().isEmpty) {
                    return 'Please enter your email';
                  }
                  email = text;
                  return null;
                },
              ),
              const SizedBox(height: 8),
              TextFormField(
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
                  mobile = text;
                  return null;
                },
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField(
                isExpanded: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Select a course'),
                items: course.map((String item) {
                  return DropdownMenuItem(value: item, child: Text(item));
                }).toList(),
                // value: selectedCourse,
                onChanged: (value) {
                  selectedCourse = value;
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
                // value: selectedUni,
                onChanged: (String? value) {
                  selectedUni = value;
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
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    Student student = Student(
                      name: name,
                      email: email,
                      mobile: mobile,
                      course: selectedCourse!,
                      uni: selectedUni!,
                    );

                    int result =
                        await DatabaseHelper.instance.saveStudent(student);

                    if (result > 0) {
                      print('Saved');
                    } else {
                      print('Failed');
                    }
                    formKey.currentState!.reset();
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreenAccent,
                    foregroundColor: Colors.black),
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
