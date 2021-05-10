import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  String get password => _account.password;
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
          SecuredDetail(SecuredDetailController("password", _accountDetailController.password)),
        ]
    );
  }

}

class PublicDetailController {
  DetailViewModel _detailViewModel;

  PublicDetailController(this._detailViewModel);

  String get value => _detailViewModel.value;
  DetailViewModel get detailViewModel => _detailViewModel;
}

class PublicDetail extends StatelessWidget {

  final PublicDetailController _controller;

  const PublicDetail(this._controller);

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
         CopyToClipBoardButton(CopyToClipBoardButtonController(_controller.detailViewModel)),
          Text(_controller.value)
        ]
    );
  }
}

class DetailViewModel {
  String _value;
  String _valueName;

  DetailViewModel(this._valueName, this._value);

  String get value => _value;
  String get valueName => _valueName;
}


class SecretViewModel implements DetailViewModel {
  String _value;
  String _displayValue;
  String _valueName;

  SecretViewModel(this._valueName, this._value, this._displayValue);

  String get value => _value;
  String get valueName => _valueName;
  String get displayValue => _displayValue;
}

class SecuredDetailController extends Cubit<SecretViewModel> {
  static const String MASKED_VALUE = "***";
  final String _valueName;
  final String _value;
  SecuredDetailController(this._valueName, this._value) : super(SecretViewModel( _valueName, _value, MASKED_VALUE));


  void showSecretButtonPressed() {
    emit(SecretViewModel( _valueName, _value, _value));
  }
}

class SecuredDetail extends StatelessWidget {

  final SecuredDetailController _controller ;

  const SecuredDetail(this._controller);

  @override
  Widget build(BuildContext context) {

   return  BlocProvider(
      create: (_) => _controller,
      child: BlocBuilder<SecuredDetailController, SecretViewModel>(
        builder: (_, SecretViewModel detailView) {
          return Row(
              children: [
                CopyToClipBoardButton(CopyToClipBoardButtonController(detailView)),
                Text(detailView.displayValue),
                IconButton(icon: Icon(Icons.visibility), onPressed: _controller.showSecretButtonPressed)
              ]
          );
        },
      ),
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

