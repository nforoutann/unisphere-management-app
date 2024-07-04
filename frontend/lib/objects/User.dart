class User {
  String name;
  String username;
  String? password;
  String? email;
  DateTime? birthday;
  List<String> ongoingTasks;

  User({
    required this.name,
    required this.username,
    this.password,
    this.email,
    this.birthday,
    required this.ongoingTasks,
  });
}