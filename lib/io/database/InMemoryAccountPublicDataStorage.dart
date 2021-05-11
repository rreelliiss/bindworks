import 'package:password_keeper/business/account.dart';
import 'package:password_keeper/business/external_interfaces/storage_interfaces.dart';

class InMemoryAccountPublicDataStorage implements AccountPublicDataStorage{
  List<AccountPublicData> accounts;
  int _counter = 0;
  InMemoryAccountPublicDataStorage():accounts=[];

  @override
  Future<AccountPublicData> addAccount(AccountPublicDataInputModel account) {
    AccountPublicData accountToStore = AccountPublicData(_counter.toString(), account.accountName, account.userName);
    accounts.add(accountToStore);
    _counter++;
    return Future.value(accountToStore);
  }

  @override
  Future<List<AccountPublicData>> getAccounts() {
    return Future.value(accounts);
  }

}