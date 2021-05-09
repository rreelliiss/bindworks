import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_keeper/business/account.dart';
import 'package:password_keeper/business/account_manager.dart';

import 'model.dart';

class AccountListController extends Cubit<List<AccountViewModel>>{
  AccountManager _accountManager;

  AccountListController(this._accountManager) : super(_getAccountViewModels(_accountManager.getAccounts())){
   _accountManager.stream.listen((accounts) =>emit(_getAccountViewModels(accounts)));
  }

  static Iterable<AccountViewModel> _getAccountViewModels(List<Account> accounts) =>
      accounts.map((a) => AccountViewModel.fromAccount(a)).toList();

}

class AccountList extends StatelessWidget {
  final AccountManager _accountManager;
  AccountList(this._accountManager);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AccountListController(_accountManager),
      child: BlocBuilder<AccountListController, List<AccountViewModel>>(
        builder: (_, accounts) {
          return ListView(children:accounts.map((a) => AccountListItem(a)).toList());
        },
      ),
    );
  }
}

class AccountListItem extends StatelessWidget {
  final AccountViewModel account;

  AccountListItem(this.account);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(account.accountName),
        Text(account.userName),
      ],
    );
  }

}