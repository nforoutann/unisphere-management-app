import 'Course.dart';

class Term{
  late int _termNumber;
  bool _active = true;
  late List<Course> _courses;

  Term(this._termNumber, this._courses);


  int get termNumber => _termNumber;
  bool get active => _active;
  List<Course> get courses => _courses;


  set termNumber(int termNumber){
    this._termNumber = termNumber;
  }
  set active(bool active){
    this._active = active;
  }
  set courses(List<Course> courses){
    this.courses = courses;
  }

}