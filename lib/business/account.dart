class Account{
  int _id;
  String _name;
  String _user;
  String _password;

  Account(this._id, this._name, this._user, this._password);

  String get name => _name;
  String get user => _user;
  int get id => _id;
  String get password => _password;
}
