import 'package:frontend/objects/Student.dart';
import 'package:frontend/objects/Task.dart';
import 'package:frontend/objects/News.dart';

class User{
  late String name;
  late String username;
  String? password;
  String? email;
  List<News> news = [];
  List<Task> tasks = [];
  DateTime? birthday;

  User(this.name, this.username);
}