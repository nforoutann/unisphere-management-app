import 'package:frontend/objects/Student.dart';
import 'package:frontend/objects/Task.dart';
import 'package:frontend/objects/News.dart';

import 'Assignment.dart';

class User{
  late String name;
  late String username;
  String? password;
  String? email;
  DateTime? birthday;
  List<Task> ongoingTasks = [];

  User(this.name, this.username);
}