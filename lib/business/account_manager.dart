import 'account.dart';

class AccountManager{
  List<Account> getAccounts(){
    return [
      Account("facebook", "jakub"),
      Account("gmail", "siller"),
      Account("github", "jakub2"),
    ];
  }
}