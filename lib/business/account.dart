class AccountPublicData{
  String _id;
  String _name;
  String _user;

  AccountPublicData(this._id, this._name, this._user);

  String get name => _name;
  String get user => _user;
  String get id => _id;
}
