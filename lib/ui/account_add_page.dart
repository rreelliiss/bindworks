import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:password_keeper/business/account.dart';
import 'package:password_keeper/business/account_manager.dart';
import 'package:password_keeper/ui/model.dart';

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

class AccountFormController {
  final AccountManager _accountManager;

  AccountFormController(this._accountManager);

  Future<void> addAccount(AccountInputModel account) async {
    _accountManager.addAccount(account); //todo await andd future buider....
  }
}


class AccountFormInputController {
  String _value;

  String get value => _value;

  set value(String value) {
    _value = value;
  }
}

class AccountForm extends StatelessWidget {
  final AccountFormController _accountFormController;

  AccountForm(this._accountFormController);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final accountNameController = TextEditingController();
    final userNameController = TextEditingController();
    final passwordController = TextEditingController();
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
        child:Container(
            padding: EdgeInsets.all(30),
            child:
            Column(
                children: [
                  TextFormField(
                    controller: accountNameController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => value.isEmpty ? "must not be empty" : null, //todo
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Enter account name' //todo
                    ),
                  ),
                  TextFormField(
                    controller: userNameController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => value.isEmpty ? "must not be empty" : null, //todo
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Enter account username' //todo
                    ),
                  ),
                  TextFormField(
                    controller: passwordController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => value.isEmpty ? "must not be empty" : null, //todo
                    obscureText: true, //todo
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Enter account name' //todo
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () { //todo extract
                      if (_formKey.currentState.validate()) {
                        AccountInputModel account = AccountInputModel(accountNameController.value.text, userNameController.value.text, passwordController.value.text);
                        _accountFormController.addAccount(account);
                        Navigator.pop(context);

                      }
                    },
                    child: Text('Submit'),
                  ),
                ]
            )
        )
    );
  }



}