import 'Teacher.dart';
import 'Student.dart';
import 'Exam.dart';
import 'Assignment.dart';

class Course{
  late Teacher _teacher;
  late String _title;
  late int _credit;
  late int _id;

  bool _active = true;
  List<Student> _students = <Student>[];
  Map<Student, double> _finalScores = Map();
  List<Assignment> _assignments = <Assignment>[];
  Map<Exam, DateTime> _examDates = Map();


  Course(this._title, this._teacher, this._credit, this._id);

  Teacher get teacher => _teacher;
  String get title => _title;
  int get credit => _credit;
  int get id => _id;
  bool get active => _active;
  List<Student> get students => _students;
  Map<Student, double> get finalScores => _finalScores;
  List<Assignment> get assignments => _assignments;
  Map<Exam, DateTime> get examDates => _examDates;


  set teacher(Teacher teacher){
    this._teacher = teacher;
  }
  set title(String title){
    this._title = title;
  }
  set credit(int credit){
    this._credit = credit;
  }
  set id(int id){
    this._id;
  }
  set active(bool active){
    this._active = active;
  }
}
