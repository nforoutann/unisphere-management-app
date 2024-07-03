import 'dart:async';
import 'dart:io';

import '../objects/Student.dart';
import '../objects/Task.dart';

class Server{

  static Future<Student> createStudent(String username, String ipAddress) async {
    String res = "";
    String name = "", email = "", currentTerm = "", strTasks = "", id = "";
    int credits = 0;
    double grade = 0;
    DateTime birthday = DateTime.now();
    bool hasBirthInfo = false;
    String command = "POST: userInfo\$${username}\u0000";
    print('Sending command: $command');

    // Create a completer to manage async response
    Completer<String> responseCompleter = Completer<String>();

    await Socket.connect(ipAddress, 8080).then((serverSocket) {
      print('Socket connected for createStudnet');
      serverSocket.write(command);
      serverSocket.flush();

      serverSocket.listen((socketResponse) {
        res = String.fromCharCodes(socketResponse);
        print('Received response: $res');
        responseCompleter.complete(res);
        serverSocket.destroy(); // Close the socket after receiving the response
      });
    }).catchError((e) {
      print('Socket error: $e');
      responseCompleter.completeError(e);
    });

    // Wait for the response to be completed
    res = await responseCompleter.future;

    List<String> resParts = res.split('\$');

    if (resParts.length >= 5) {
      name = resParts[0];
      id = resParts[1];
      currentTerm = resParts[2];
      email = resParts[3];

      String birth = resParts[4];
      if (birth.isNotEmpty) {
        birth = birth.substring(1, birth.length - 1);
        int year = int.parse(birth.split('-')[0]);
        int month = int.parse(birth.split('-')[1]);
        int day = int.parse(birth.split('-')[2]);
        birthday = DateTime(year, month, day);
        hasBirthInfo = true;
      }

      if (resParts.length > 5) {
        strTasks = resParts[5];
      }

      if (resParts.length > 6) {
        String strGrade = resParts[6];
        grade = double.parse(strGrade);
      }
    } else {
      // Handle the case where the response does not have enough parts
      print("Response does not have enough parts: $res");
    }

    Student student = Student(name, username);
    student.id = id;
    student.currentTerm = currentTerm;
    student.email = email;
    if (hasBirthInfo) {
      student.birthday = birthday;
    }
    student.totalGrade = grade;
    if (strTasks.isNotEmpty) {
      List<String> Tasks = strTasks.split('//');
      for (int i = 0; i < Tasks.length; i++) {
        List<String> taskParts = Tasks[i].split('~');
        if (taskParts.length > 1) {
          String title = taskParts[0];
          bool done = taskParts[1] == 'yes';
          student.ongoingTasks.add(Task(title: title, done: done));
        }
      }
    }

    return student;
  }

}