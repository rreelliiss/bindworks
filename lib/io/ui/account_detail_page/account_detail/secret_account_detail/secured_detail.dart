import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_keeper/io/ui/account_detail_page/account_detail/copy_to_clipboard_button/copy_to_clipboard_button.dart';
import 'package:password_keeper/io/ui/account_detail_page/account_detail/secret_account_detail/model.dart';

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