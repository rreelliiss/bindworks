import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:password_keeper/business/account.dart';
import 'package:password_keeper/io/ui/add_account_page/add_account_form/add_acount_form.dart';

class AccountAddPageController{

}

class AccountAddPage extends StatelessWidget {
  final AccountAddPageController _accountDetailPageController;
  final AccountManager _accountManager;
  AccountAddPage(this._accountDetailPageController, this._accountManager);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("add account"), //todo
      ),
      body: AccountForm(AccountFormController(_accountManager)),
    );
  }

}

