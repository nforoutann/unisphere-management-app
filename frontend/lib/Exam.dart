class Exam{
  late ExamType _type;
  late DateTime _deadline;
  bool _active = true;
  int? _id;

  Exam(this._type, this._deadline);

  ExamType get examtype => _type;
  DateTime get deadline => _deadline;
  bool get active => _active;
  int? get id => _id;

  set type(ExamType type){
    this._type = type;
  }
  set deadline(DateTime deadline){
    this._deadline = deadline;
  }
  set active(bool active){
    this._active = active;
  }
  set id(int? id) {
    this._id = id;
  }
}

enum ExamType{
  Quiz,
  MidTerm,
  FinalTerm,
}