import 'package:flutter/material.dart';
import 'package:password_keeper/io/ui/account_detail_page/account_detail/copy_to_clipboard_button/copy_to_clipboard_button.dart';
import 'package:password_keeper/io/ui/account_detail_page/account_detail/model.dart';

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