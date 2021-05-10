import 'package:bloc/bloc.dart';

import 'account.dart';

class AccountInputModel {
  final String _accountName;
  final String _userName;
  final String _password;
  AccountInputModel(this._accountName, this._userName, this._password);
}

class AccountManager extends Cubit<List<Account>>{
  List<Account> getAccounts(){
    return state;
  }

  addAccount(AccountInputModel accountToAdd) {
    List<Account> newState = List.from(state);
    newState.add(Account(state.length, accountToAdd._accountName, accountToAdd._userName));
    emit(newState);
  }

  AccountManager(): super( [
    Account(0,"facebook", "jakub"),
    Account(1,"gmail", "siller"),
    Account(2,"github", "jakub2"),
  ]);
}