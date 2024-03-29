import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:student_registration_app/utility/data_store.dart';
import 'package:student_registration_app/models/student.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor(); // Name constructor to create instance of database
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  // getter for database
  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS
    // to store database

    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}/decode.db';

    // open/create database at a given path
    var studentsDatabase = await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );

    return studentsDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('''Create TABLE $tableStudent (
                  $colId INTEGER PRIMARY KEY AUTOINCREMENT,
                  $colName TEXT,
                  $colEmail TEXT UNIQUE,
                  $colMobile TEXT,
                  $colCourse TEXT,
                  $colUni TEXT
                   );
    ''');
  }

  // insert operation
  // adding single Student Information to the Student Table
  Future<int> saveStudent(Student student) async {
    Database db = await instance.database;

    // String insertQuery = '''
    // INSERT INTO $tableStudent
    // ($colName, $colEmail, $colMobile, $colCourse, $colUni,)
    // VALUES
    // (?, ?, ?, ?, ?)
    // ''';

    // int result = await db.rawInsert(
    //   insertQuery,
    //   [
    //     student.name,
    //     student.email,
    //     student.mobile,
    //     student.course,
    //     student.uni
    //   ],
    // );

    int result = await db.insert(tableStudent, student.toMap());

    // based on the result value, we will know whether the record was saved
    // OR not saved. Same thing will apply in other operations.
    return result;
  }

  // read operation
  Future<List<Student>> getAllStudents() async {
    final List<Student> students = [];
    Database db = await instance.database;

    // getting the list of student objects stored as maps in student table
    List<Map<String, dynamic>> listMap = await db.query(tableStudent);

    // converting each item in the list to Student object and storing it into the students List.
    for (var item in listMap) {
      final student = Student.fromMap(item);
      students.add(student);
    }

    // custom delay
    await Future.delayed(const Duration(seconds: 3));

    return students;
  }

  // delete operation
  Future<int> deleteStudent(int id) async {
    Database db = await instance.database;
    int result =
        await db.rawDelete('DELETE FROM $tableStudent where id=?', [id]);

    // simple delete
    // int result = await db.delete(tableStudent, where: 'id=?', whereArgs: [id]);
    return result;
  }

  // update operation
  Future<int> updateStudent(Student student) async {
    Database db = await instance.database;

    int result = await db.update(tableStudent, student.toMap(),
        where: 'id=?', whereArgs: [student.id]);
    return result;
  }

  // search operation
  Future<List<Student>> searchStudents(String name) async {
    Database db = await instance.database;
    List<Student> studentList = [];

    List<Map<String, Object?>> listMapOfStudents = await db
        .query(tableStudent, where: 'name like ?', whereArgs: ['%$name%']);

    for (var studentMap in listMapOfStudents) {
      Student student = Student.fromMap(studentMap);
      studentList.add(student);
    }

    await Future.delayed(const Duration(seconds: 3));
    return studentList;
  }
}
