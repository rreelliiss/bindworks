import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'account_list.dart';

class AccountListPage extends StatelessWidget {
  AccountListPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Accounts"),
      ),
      body: AccountList(),
    );
  }
}
