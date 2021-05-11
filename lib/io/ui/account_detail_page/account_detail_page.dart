import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_keeper/business/account.dart';
import 'package:password_keeper/io/ui/account_detail_page/account_detail/model.dart';
import 'package:password_keeper/io/ui/account_detail_page/account_detail/public_account_detail/public_detail.dart';
import 'package:password_keeper/io/ui/account_detail_page/account_detail/secret_account_detail/secured_detail.dart';
import 'package:password_keeper/io/ui/model.dart';

class AccountDetailPageController{
  AccountPublicDataViewModel _account;
  AccountManager _accountManager;
  AccountDetailPageController(this._account, this._accountManager);

  String get accountName => _account.accountName;
  AccountDetailController createAccountDetailController() => AccountDetailController(_account, _accountManager);
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
  AccountPublicDataViewModel _account;
  AccountManager _accountManager;
  AccountDetailController(this._account, this._accountManager);

  String get accountName => _account.accountName;
  String get userName => _account.userName;

  Future<String> get password async => await _accountManager.getPasswordOfAccount(_account.id); //todo when doesn't exist
}

class AccountDetail extends StatelessWidget {
  final AccountDetailController _accountDetailController;

  AccountDetail(this._accountDetailController);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          PublicDetail(PublicDetailController(DetailViewModel("account Name", _accountDetailController.accountName))),
          PublicDetail(PublicDetailController(DetailViewModel("user Name", _accountDetailController.userName))),
          FutureBuilder(
              future: _accountDetailController.password,
              builder: (context, AsyncSnapshot<String> snapshot){
                if(snapshot.hasError){
                  return Text("error during loading password"); //todo;
                } else  if(snapshot.hasData){
                return SecuredDetail(SecuredDetailController("password", snapshot.data));
                }
                return Center( child: CircularProgressIndicator());
              }

          )

        ]
    );
  }

}



class CopyToClipBoardButtonController {
  DetailViewModel _detailViewModel;

  CopyToClipBoardButtonController(this._detailViewModel);

  String get copiedToClipBoardMessage => _detailViewModel.valueName + " was copied to clipboard";
  int get copiedToClipBoardMessageDuration => 3;

  void copyPressed(BuildContext context){
    Clipboard.setData(ClipboardData(text: _detailViewModel.value));
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(copiedToClipBoardMessage),
      duration: Duration(seconds: copiedToClipBoardMessageDuration),
    ));
  }
}

class CopyToClipBoardButton extends StatelessWidget {
  final CopyToClipBoardButtonController _clipBoardButtonController;

  const CopyToClipBoardButton(this._clipBoardButtonController);

  @override
  Widget build(BuildContext context) {
    return  IconButton(
        icon: Icon(Icons.copy),
        onPressed: () => _clipBoardButtonController.copyPressed(context)
    );
  }
}

