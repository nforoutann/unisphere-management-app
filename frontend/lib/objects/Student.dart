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
  List<Assignment> doneAssignments = [];
  int? numberOfLostAssignments;

  Student({
    required String name,
    required String username,
    required String password,
    required String email,
    DateTime? birthday,
    required List<Task> ongoingTasks,
    required this.id,
    required this.credits,
    required this.currentTerm,
    required this.totalGrade,
    required this.bestScore,
    required this.worstScore,
    required this.numberOfLeftAssignments,
    required this.doneAssignments,
    required this.numberOfExams,
    required this.numberOfLostAssignments,
  }) : super(
    name: name,
    username: username,
    password: password,
    email: email,
    birthday: birthday,
    ongoingTasks: ongoingTasks,
  );

  factory Student.fromJson(Map<String, dynamic> json) {
    List<Assignment> assignmentsList = [];
    if (json['doneAssignments'] != null) {
      var assignmentsJson = json['doneAssignments'] as List;
      assignmentsList = assignmentsJson
          .map((assignmentJson) => Assignment.fromJson(assignmentJson))
          .toList();
    }
    List<Task> ongoingTaskList = [];
    if (json['ongoingTasks'] != null) {
      var tasksJson = json['ongoingTasks'] as List;
      ongoingTaskList = tasksJson
          .map((taskJson) => Task.fromJson(taskJson))
          .toList();
    }

    String birthdayStr = json['birthday'];
    DateTime? birthday;
    if(birthdayStr != "{}"){
      birthdayStr = birthdayStr.substring(1, birthdayStr.length-1);
      var birthInfo = birthdayStr.split("~");
      birthday = DateTime(int.parse(birthInfo[0]), int.parse(birthInfo[1]), int.parse(birthInfo[2]));
    }

    return Student(
      name: json['name'],
      username: json['username'],
      password: json['password'],
      email: json['email'],
      birthday: birthday,
      ongoingTasks: ongoingTaskList, // Assuming you deserialize this elsewhere
      id: json['id'].toString(),
      credits: json['credits'],
      currentTerm: json['currentTerm'].toString(),
      totalGrade: json['totalGrade'],
      bestScore: json['bestScore'],
      worstScore: json['worstScore'],
      numberOfLeftAssignments: json['numberOfLeftAssignments'],
      doneAssignments: assignmentsList,
      numberOfExams: json['numberOfExams'],
      numberOfLostAssignments: json['numberOfLostAssignments']
    );
  }
}