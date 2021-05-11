import 'package:flutter/material.dart';
import 'package:password_keeper/business/account.dart';
import 'package:password_keeper/io/ui/account_detail_page/account_detail_page.dart';
import 'package:password_keeper/io/ui/model.dart';

class AccountListItemController {
  final AccountPublicDataViewModel account;
  AccountManager _accountManager;
  AccountListItemController(this.account, this._accountManager);

  String get accountName => account.accountName;
  String get userName => account.userName;

  onTap(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => AccountDetailPage(AccountDetailPageController(account, _accountManager))));
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