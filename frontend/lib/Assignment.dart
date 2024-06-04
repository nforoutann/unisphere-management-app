class Assignment{
  bool _active = true;
  late int _MaxScore;
  late String _title;
  late AssignmentType _assignmentType;
  late DateTime _deadline;

  Assignment(this._MaxScore, this._title, this._assignmentType, this._deadline);

  int get MaxScore => _MaxScore;
  String get title => _title;
  AssignmentType get assignmentType => _assignmentType;
  DateTime get deadline => _deadline;
  bool get active => _active;

  set active(bool active){
    this._active = active;
  }
  set MaxScore(int MaxScore){
    this._MaxScore = MaxScore;
  }
  set title(String title){
    this._title = title;
  }
  set assignment(AssignmentType assignmentType){
    this._assignmentType = assignmentType;
  }
  set deadLine(DateTime deadLine){
    this._deadline = deadLine;
  }

}
enum AssignmentType{
  EXERCISE, PROJECT
}
