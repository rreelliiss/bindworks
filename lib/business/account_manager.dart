import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'account.dart';

class AccountPublicDataInputModel {
  final String _accountName;
  final String _userName;

  AccountPublicDataInputModel(this._accountName, this._userName);

  String get userName => _userName;
  String get accountName => _accountName;
}

class AccountInputModel {
  final AccountPublicDataInputModel _accountPublicDataInputModel;
  final String _password;
  AccountInputModel(accountName, userName, this._password):
        _accountPublicDataInputModel = AccountPublicDataInputModel(accountName, userName);

  String get password => _password;
  AccountPublicDataInputModel get accountPublicDataInputModel =>
      _accountPublicDataInputModel;


}

class AccountsCubit extends Cubit<List<AccountPublicData>>{
  AccountsCubit(List<AccountPublicData> initialState) : super(initialState);

  void setAccounts(List<AccountPublicData> accounts) {
    emit(accounts);
  }

}

class AccountManager {

  final AccountsCubit _accountsCubit;
  final AccountPublicDataStorage _publicDataStorage;
  final PasswordsStorage _passwordsStorage;

  AccountsCubit get accountsCubit => _accountsCubit;

  List<AccountPublicData> getAccounts(){
    return _accountsCubit.state;
  }

  addAccount(AccountInputModel accountToAdd) async {
    AccountPublicData account = await _publicDataStorage.addAccount(accountToAdd.accountPublicDataInputModel);
    await _passwordsStorage.storePassword(account.id, accountToAdd.password);
    List<AccountPublicData> newAccounts = [];
    newAccounts.addAll(await _publicDataStorage.getAccounts());
    _accountsCubit.setAccounts(newAccounts);
  }

  Future<String> getPasswordOfAccount(String id) async {
    return await _passwordsStorage.getPassword(id);
  }

  AccountManager(publicDataStorage, passwordsStorage):
        _passwordsStorage=passwordsStorage, _publicDataStorage=publicDataStorage ,_accountsCubit = AccountsCubit([]);

}

abstract class AccountPublicDataStorage {
  Future<List<AccountPublicData>> getAccounts();
  Future<AccountPublicData> addAccount(AccountPublicDataInputModel account);
}

class InMemoryAccountPublicDataStorage implements AccountPublicDataStorage{
  List<AccountPublicData> accounts;
  int _counter = 0;
  InMemoryAccountPublicDataStorage():accounts=[];

  @override
  Future<AccountPublicData> addAccount(AccountPublicDataInputModel account) {
    AccountPublicData accountToStore = AccountPublicData(_counter.toString(), account.accountName, account.userName);
    accounts.add(accountToStore);
    _counter++;
    return Future.value(accountToStore);
  }

  @override
  Future<List<AccountPublicData>> getAccounts() {
    return Future.value(accounts);
  }

}

abstract class PasswordsStorage {
  Future<void>  storePassword(String id, String password);
  Future<String> getPassword(String id);
}

class SecurePasswordStorage implements PasswordsStorage {
  final storage = new FlutterSecureStorage();

  @override
  Future<String> getPassword(String id) async {
    return await storage.read(key: id);
  }

  @override
  Future<void> storePassword(String id, String password) async {
    await storage.write(key: id, value: password);
  }

}