
import 'package:password_keeper/io/ui/account_detail_page/account_detail/model.dart';

class SecretViewModel implements DetailViewModel {
  String _value;
  String _displayValue;
  String _valueName;

  SecretViewModel(this._valueName, this._value, this._displayValue);

  String get value => _value;
  String get valueName => _valueName;
  String get displayValue => _displayValue;
}
