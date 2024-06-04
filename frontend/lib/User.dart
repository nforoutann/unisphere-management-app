class User{
  late String _firstName;
  late String _lastName;
  late int _id;
  String? _password;

  User(this._firstName, this._lastName, this._id);

  String get firstName => _firstName;
  String get lastName => _lastName;
  int get id => _id;
  String? get password => _password;

  set firstName(String firstName){
    _firstName = firstName;
  }
  set lastName(String lastName){
    _lastName = lastName;
  }
  set id(int id){
    _id = id;
  }
  set password(String? password){
    _password = password;
  }

}