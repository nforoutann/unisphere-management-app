class User{
  late String _name;
  late String _username;
  String? _password;

  User(this._name, this._username);

  String get name => _name;
  String get username => _username;
  String? get password => _password;

  set name(String name){
    _name = name;
  }
  set username(String username){
    _username = username;
  }
  set password(String? password){
    _password = password;
  }

}