import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:password_keeper/business/account.dart';
import 'package:password_keeper/io/database/InMemoryAccountPublicDataStorage.dart';
import 'package:password_keeper/io/database/SecurePasswordStorage.dart';
import 'package:password_keeper/io/ui/add_account_page/account_add_page.dart';

import 'account_list/account_list.dart';

class AccountListPageController{
  final AccountManager _accountManager = AccountManager(InMemoryAccountPublicDataStorage(), SecurePasswordStorage());
  AccountManager get accountManager => _accountManager;
  String get pageTitle => "Accounts";

  addAccountPressed(BuildContext context){
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
        title: Text(_accountListPageController.pageTitle),
      ),
      body: AccountList(AccountListController(_accountListPageController.accountManager)),
      floatingActionButton: IconButton(
        icon: Icon(Icons.add),
        onPressed: () => _accountListPageController.addAccountPressed(context) ,
      ),
    );
  }
}
