import 'dart:convert';
import 'dart:typed_data';
import 'package:frontend/objects/Task.dart';
import 'package:frontend/objects/User.dart';

import 'Assignment.dart';

class Student extends User {
  String? id;
  int? credits;
  String? currentTerm;
  double? totalGrade;
  double? bestScore;
  double? worstScore; 
  int? numberOfLeftAssignments;
  int? numberOfExams;
  List<Assignment> ongoingAssignments = [];

  Student(String name, String username) : super(name, username);

  static Student deserialize(Uint8List bytes) {
    var buffer = ByteData.sublistView(bytes);
    int offset = 0;

    // Read UTF string with length prefix
    String readString(ByteData buffer, int offset) {
      int length = buffer.getUint16(offset, Endian.big);
      offset += 2;
      String value = utf8.decode(buffer.buffer.asUint8List(offset, length));
      offset += length;
      return value;
    }

    String name = readString(buffer, offset);
    String username = readString(buffer, offset);
    Student student = Student(name, username);

    student.id = readString(buffer, offset);
    student.currentTerm = readString(buffer, offset);
    student.email = readString(buffer, offset);

    int timestamp = buffer.getInt64(offset, Endian.big);
    offset += 8;
    student.birthday = DateTime.fromMillisecondsSinceEpoch(timestamp);

    student.totalGrade = buffer.getFloat64(offset, Endian.big);
    offset += 8;

    int taskCount = buffer.getInt32(offset, Endian.big);
    offset += 4;
    for (int i = 0; i < taskCount; i++) {
      student.ongoingTasks.add(Task.deserialize(buffer, offset));
    }

    return student;
  }
}