import 'package:flutter/material.dart';
import 'package:student_registration_app/models/student.dart';
import 'package:student_registration_app/widgets/info_container.dart';

class StudentCard extends StatelessWidget {
  const StudentCard({
    super.key,
    required this.studentData,
    required this.onDelete,
    required this.onUpdate,
  });

  final Student studentData;
  final void Function() onDelete;
  final void Function() onUpdate;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [
            Colors.deepPurple,
            Colors.purple,
          ]),
          // color: Colors.deepPurpleAccent,
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              InfoContainer(
                  backgroundColor: Colors.black,
                  text: studentData.id.toString()),
              const SizedBox(width: 8),
              Text(
                studentData.name,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  letterSpacing: 1.5,
                  height: 1.5,
                ),
              ),
            ],
          ),
          InfoContainer(
            backgroundColor: Colors.black54,
            text: studentData.course,
            fontSize: 16,
          ),
          const SizedBox(height: 8),
          Wrap(
            runSpacing: 4,
            children: [
              InfoContainer(
                backgroundColor: Colors.white70,
                text: studentData.email,
                foregroundColor: Colors.black87,
                fontSize: 14,
              ),
              const SizedBox(width: 4),
              InfoContainer(
                backgroundColor: Colors.white70,
                text: studentData.mobile,
                foregroundColor: Colors.black87,
                fontSize: 14,
              ),
            ],
          ),
          const SizedBox(height: 4),
          InfoContainer(
            backgroundColor: Colors.white70,
            text: studentData.uni,
            foregroundColor: Colors.black87,
            fontSize: 14,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent.withOpacity(0.8),
                    foregroundColor: Colors.white.withOpacity(0.9),
                  ),
                  icon: const Icon(Icons.delete_forever),
                  onPressed: onDelete,
                  label: const Text('Delete')),
              const SizedBox(width: 10),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.withOpacity(0.8),
                    foregroundColor: Colors.white.withOpacity(0.9),
                  ),
                  icon: const Icon(Icons.update),
                  onPressed: onUpdate,
                  label: const Text('Update')),
            ],
          )
        ],
      ),
    );
  }
}
