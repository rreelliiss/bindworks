class Account{
  int _id;
  String _name;
  String _user;

  Account(this._id, this._name, this._user);

  String get name => _name;
  String get user => _user;
  int get id => _id;
}
