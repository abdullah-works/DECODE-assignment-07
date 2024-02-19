import 'package:flutter/material.dart';
import 'package:student_registration_app/screens/add_student_screen.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  // Only for Linux
  // Initialize FFI
  sqfliteFfiInit();

  // Change the default factory.
  databaseFactory = databaseFactoryFfi;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AddStudentScreen(),
    );
  }
}
