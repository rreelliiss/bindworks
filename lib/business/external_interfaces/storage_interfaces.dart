import 'package:password_keeper/business/account.dart';

abstract class AccountPublicDataStorage {
  Future<List<AccountPublicData>> getAccounts();
  Future<AccountPublicData> addAccount(AccountPublicDataInputModel account);
}

abstract class PasswordsStorage {
  Future<void>  storePassword(String id, String password);
  Future<String> getPassword(String id);
}