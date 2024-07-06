import '../objects/Task.dart';

class User {
  String name;
  String username;
  String? password;
  String? email;
  DateTime? birthday;
  List<Task> ongoingTasks;

  User({
    required this.name,
    required this.username,
    this.password,
    this.email,
    this.birthday,
    required this.ongoingTasks,
  });
}