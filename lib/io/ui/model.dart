import 'package:password_keeper/business/account.dart';

class AccountPublicDataViewModel {
  String _id;
  String _accountName;
  String _userName;

  String get userName => _userName;
  String get accountName => _accountName;
  String get id => _id;

  AccountPublicDataViewModel.fromAccount(AccountPublicData a):
        this._id = a.id, this._accountName = a.name, this._userName = a.user;
}
