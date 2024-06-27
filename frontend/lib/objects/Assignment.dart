class Assignment{
  bool active = true;
  late int score;
  late int myScore;
  late String title;
  late AssignmentType assignmentType;
  late DateTime deadline;

  Assignment(this.score, this.title, this.assignmentType, this.deadline);

}
enum AssignmentType{
  EXERCISE, PROJECT
}
