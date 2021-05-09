import 'package:flutter/material.dart';
import 'package:password_keeper/ui/account_list_page.dart';

void main() {
  runApp(PasswordKeeperApp());
}

class PasswordKeeperApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AccountListPage(AccountListPageController())
    );
  }
}
