import 'User.dart';

class Student extends User{
  String? id;
  int? credits;
  String? currentTerm;
  double? grade;
  Student(String name, String username) : super(name, username);
}