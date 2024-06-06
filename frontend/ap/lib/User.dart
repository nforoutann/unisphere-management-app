class User{
  late String _name;
  late String _username;
  late int _id;
  String? _password;

  User(this._name, this._id);

  String get name => _name;
  String get username => _username;
  int get id => _id;
  String? get password => _password;

  set name(String name){
    _name = name;
  }
  set username(String username){
    _username = username;
  }
  set id(int id){
    _id = id;
  }
  set password(String? password){
    _password = password;
  }

}