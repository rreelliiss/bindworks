import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:password_keeper/ui/model.dart';

class AccountAddPageController{

}

class AccountAddPage extends StatelessWidget {
  final AccountAddPageController _accountDetailPageController;
  AccountAddPage(this._accountDetailPageController);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("add account"), //todo
      ),
      body: AccountForm(AccountFormController()),
    );
  }

}

class AccountFormController {
}


class AccountFormInputController {
  String _value;

  String get value => _value;

  set value(String value) {
    _value = value;
  }
}

// class AccountFormInput extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
//     return
//   }
//
// }

class AccountForm extends StatelessWidget {
  final AccountFormController _accountDetailController;

  AccountForm(this._accountDetailController);

  @override
  Widget build(BuildContext context) {
    return Form(
        child:Column(
            children: [
              TextFormField(),
              TextFormField(),
              TextFormField()
            ]
        ));
  }



}