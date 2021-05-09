import 'package:bloc/bloc.dart';

import 'account.dart';

class AccountManager extends Cubit<List<Account>>{
  List<Account> getAccounts(){
    return state;
  }

  addAccount() {
    List<Account> newState = List.from(state);
    newState.add(Account(state.length, "github", "jakub2"));
    emit(newState);
  }

  AccountManager(): super( [
    Account(0,"facebook", "jakub"),
    Account(1,"gmail", "siller"),
    Account(2,"github", "jakub2"),
  ]);
}