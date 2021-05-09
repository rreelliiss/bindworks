import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_keeper/business/account.dart';
import 'package:password_keeper/business/account_manager.dart';

import 'model.dart';

class AccountListController extends Cubit<List<AccountViewModel>>{
  AccountListController() : super(_getAccountViewModels(AccountManager().getAccounts()));

  static Iterable<AccountViewModel> _getAccountViewModels(List<Account> accounts) =>
      accounts.map((a) => AccountViewModel.fromAccount(a));

}

class AccountList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AccountListController(),
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