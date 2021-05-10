import 'package:password_keeper/business/account.dart';

class AccountViewModel {
  String _accountName;
  String _userName;
  String _passWord;

  String get userName => _userName;
  String get accountName => _accountName;

  AccountViewModel(this._accountName, this._userName, this._passWord);

  AccountViewModel.fromAccount(Account a):
        this._accountName = a.name, this._userName = a.user, this._passWord = a.password;

  get password => _passWord;
}