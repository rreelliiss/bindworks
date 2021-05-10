import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:password_keeper/business/account_manager.dart';

import 'account_add_page.dart';
import 'account_list.dart';

class AccountListPageController{
  final AccountManager _accountManager = AccountManager();


  AccountManager get accountManager => _accountManager;

  addAccount(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context) => AccountAddPage(AccountAddPageController(), _accountManager)));

  }
}

class AccountListPage extends StatelessWidget {
  final AccountListPageController _accountListPageController;
  AccountListPage(this._accountListPageController);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Accounts"),
      ),
      body: AccountList(AccountListController(_accountListPageController.accountManager)),
      floatingActionButton: IconButton(
        icon: Icon(Icons.add),
        onPressed: () => _accountListPageController.addAccount(context) ,
      ),
    );
  }
}
