import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_keeper/business/account.dart';
import 'package:password_keeper/business/account_manager.dart';
import 'package:password_keeper/ui/account_detail_page.dart';

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
  final AccountListController _accountListController;
  AccountList(this._accountListController);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _accountListController,
      child: BlocBuilder<AccountListController, List<AccountViewModel>>(
        builder: (_, accounts) {
          return ListView(
              children: accounts.map(
                      (a) => AccountListItem(
                          AccountListItemController(a)
                      )
              ).toList());
        },
      ),
    );
  }
}


class AccountListItemController {
  final AccountViewModel account;

  AccountListItemController(this.account);

  String get accountName => account.accountName;
  String get userName => account.userName;

  onTap(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => AccountDetailPage(AccountDetailPageController(account))));
  }
}

class AccountListItem extends StatelessWidget {
  final AccountListItemController controller;
  AccountListItem(this.controller);

  @override
  Widget build(BuildContext context) {
    return
        ListTile(
          title:  Row(
            children: [
              Text(controller.accountName),
              Text(controller.userName),
            ],
          ),
            onTap: () => controller.onTap(context),
        );


  }

}