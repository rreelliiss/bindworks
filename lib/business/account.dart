import 'package:bloc/bloc.dart';
import 'package:password_keeper/business/external_interfaces/storage_interfaces.dart';

class AccountPublicData{
  String _id;
  String _name;
  String _user;

  AccountPublicData(this._id, this._name, this._user);

  String get name => _name;
  String get user => _user;
  String get id => _id;
}


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
  AccountPublicDataInputModel get accountPublicDataInputModel => _accountPublicDataInputModel;


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


