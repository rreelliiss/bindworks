import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:password_keeper/ui/model.dart';

class AccountDetailPageController{
  AccountViewModel _account;
  AccountDetailPageController(this._account);

  String get accountName => _account.accountName;
  AccountDetailController createAccountDetailController() => AccountDetailController(_account);
}

class AccountDetailPage extends StatelessWidget {
  final AccountDetailPageController _accountDetailPageController;
  AccountDetailPage(this._accountDetailPageController);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_accountDetailPageController.accountName),
      ),
      body: AccountDetail(_accountDetailPageController.createAccountDetailController()),
    );
  }

}

class AccountDetailController {
  AccountViewModel _account;
  AccountDetailController(this._account);

  String get accountName => _account.accountName;
  String get userName => _account.userName;
}

class AccountDetail extends StatelessWidget {
  final AccountDetailController _accountDetailController;

  AccountDetail(this._accountDetailController);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row( children: [
          IconButton(icon: Icon(Icons.copy), onPressed: (){
      Clipboard.setData(ClipboardData(text: _accountDetailController.accountName));
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('Copied to clipboard'), duration: Duration(seconds: 3),));
    },), Text(_accountDetailController.accountName)]),
        Row( children: [Text(_accountDetailController.userName)]),
        Row( children: [Text("***")]),
    ]
    );
  }

}