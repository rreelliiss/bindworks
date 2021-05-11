import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:password_keeper/io/ui/account_detail_page/account_detail/model.dart';

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
