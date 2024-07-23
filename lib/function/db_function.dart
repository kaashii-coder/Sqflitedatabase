import 'package:flutter/material.dart';
import 'package:main_weekfive/model/studentmodel.dart';
import 'package:sqflite/sqflite.dart';

ValueNotifier<List<StudentModel>> studentListnotifier = ValueNotifier([]);
late Database _db;

Future<void> initializDatabase() async {
  _db = await openDatabase(
    'student.db',
    version: 1,
    onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE student(id INTEGER PRIMARY KEY,name TEXT,age TEXT, address TEXT,domain TEXT,image BLOB )');
    },
    onUpgrade: (db, oldVersion, newVersion) {
      db.execute('ALTER TABLE student ADD COLUMN newgen');
    },
  );
}

Future<void> addStudent(StudentModel value) async {
  await initializDatabase();
  await _db.rawInsert(
      'INSERT INTO student(name,age,address,domain,image) VALUES(?,?,?,?,?)',
      [value.name,value.age,value.address,value.domain,value.image]);
  getAllStudents();
}

Future<void> getAllStudents() async { 
  await initializDatabase();
  final values = await _db.rawQuery('SELECT * FROM student');
  studentListnotifier.value.clear();
  for (var map in values) {
    final student = StudentModel.fromMap(map);
    studentListnotifier.value.add(student);
    studentListnotifier.notifyListeners();
  }
}

Future<void> updateStudent(StudentModel studentModel, id) async {
  await initializDatabase();
  await _db.rawUpdate(
      'UPDATE student SET name =?,age =?,address=?,domain=?,image=? where id=?',
      [
        studentModel.name,
        studentModel.age,
        studentModel.address,
        studentModel.domain,
        studentModel.image,
        id
      ]);

  studentListnotifier.notifyListeners();
  await getAllStudents();
}

Future<void> deleteAstudent(int id) async {
  await initializDatabase();
  await _db.rawDelete('DELETE FROM student WHERE id=?', [id]);
  studentListnotifier.value.clear();
  studentListnotifier.notifyListeners();
  await getAllStudents();
}

searchIteams(String searchTerm) async {
  await initializDatabase();
  final List<Map<String, dynamic>> result = await _db.query(
    'student',
    where: 'name LIKE ?',
    whereArgs: ['%$searchTerm%'],
  );
  studentListnotifier.value.clear();
  result.forEach((map) {
    final student = StudentModel.fromMap(map);
    studentListnotifier.value.add(student);
  });
  studentListnotifier.notifyListeners();
}
