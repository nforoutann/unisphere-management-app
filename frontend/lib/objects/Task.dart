class Task {
  String title;
  bool done;
  DateTime time;


  Task({
    required this.title,
    required this.done,
    required this.time
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    String date = json['doAtTime'];
    date = date.substring(1, date.length-1);
    DateTime time = DateTime(int.parse(date.split("::")[0]), int.parse(date.split("::")[1]), int.parse(date.split("::")[2]), int.parse(date.split("::")[3]), int.parse(date.split("::")[4]));
    return Task(
      title: json['title'],
      done: json['done'],
      time: time,
    );
  }

  @override
  String toString() {
    return 'Task{title: $title, done: $done}';
  }
}
