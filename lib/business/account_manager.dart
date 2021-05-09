import 'package:bloc/bloc.dart';

import 'account.dart';

class AccountManager extends Cubit<List<Account>>{
  List<Account> getAccounts(){
    return state;
  }

  addAccount() {
    List<Account> newState = List.from(state);
    newState.add(Account("github", "jakub2"));
    emit(newState);
  }

  AccountManager(): super( [
    Account("facebook", "jakub"),
    Account("gmail", "siller"),
    Account("github", "jakub2"),
  ]);
}