class Task {
  String title;
  bool done;

  Task({
    required this.title,
    required this.done,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'],
      done: json['done'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'done': done,
    };
  }

  @override
  String toString() {
    return 'Task{title: $title, done: $done}';
  }
}
