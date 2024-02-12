import 'package:student_registration_app/utility/data_store.dart';

class Student {
  Student({
    this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.course,
    required this.uni,
  });

  late int? id;
  late String name;
  late String email;
  late String mobile;
  late String course;
  late String uni;

  // .toMap() Method
  // Convert Student Object to Map (for Database storage)
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      colId: id,
      colName: name,
      colEmail: email,
      colMobile: mobile,
      colCourse: course,
      colUni: uni,
    };

    return map;
  }

  // .fromMap() Constructor
  // Convert Map to Student Object
  Student.fromMap(Map<String, dynamic> map) {
    id = map[colId];
    name = map[colName];
    email = map[colEmail];
    mobile = map[colMobile];
    course = map[colCourse];
    uni = map[colUni];
  }
}
