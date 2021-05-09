import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:password_keeper/business/account_manager.dart';

import 'account_list.dart';

class AccountListPage extends StatelessWidget {
  final AccountManager _accountManager = AccountManager();
  AccountListPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Accounts"),
      ),
      body: AccountList(AccountListController(_accountManager)),
      floatingActionButton: IconButton(
        icon: Icon(Icons.add),
        onPressed: () => _accountManager.addAccount() ,
      ),
    );
  }
}
