import 'package:flutter/material.dart';
import 'package:student_registration_app/models/student.dart';
import 'package:student_registration_app/widgets/info_container.dart';

class StudentCard extends StatelessWidget {
  const StudentCard({super.key, required this.studentData});

  final Student studentData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
          color: Colors.deepPurpleAccent,
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            studentData.name,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w500,
              color: Colors.white,
              letterSpacing: 1.5,
              height: 1.5,
            ),
          ),
          InfoContainer(
            backgroundColor: Colors.black54,
            text: studentData.course,
            fontSize: 16,
          ),
          InfoContainer(
            backgroundColor: Colors.white54,
            text: studentData.email,
            foregroundColor: Colors.black87,
            fontSize: 14,
          ),
          Row(
            children: [
              InfoContainer(
                backgroundColor: Colors.greenAccent,
                text: studentData.mobile,
                foregroundColor: Colors.black87,
                fontSize: 14,
              ),
              const SizedBox(width: 8),
              InfoContainer(
                backgroundColor: Colors.cyanAccent,
                text: studentData.uni,
                foregroundColor: Colors.black87,
                fontSize: 14,
              ),
            ],
          )
        ],
      ),
    );
  }
}
