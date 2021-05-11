import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:password_keeper/business/account.dart';
import 'package:password_keeper/business/external_interfaces/storage_interfaces.dart';

import 'account_test.mocks.dart';

@GenerateMocks([PasswordsStorage, AccountPublicDataStorage])
void main(){
  group("AccountManager", ()
  {
    test('AccountManager returns future of password from provided storage', () {
      //assume
      final passwordStorage = MockPasswordsStorage();
      when(passwordStorage.getPassword("foo")).thenAnswer((_) =>
          Future.value("bar"));
      final accountPublicDataStorage = MockAccountPublicDataStorage();

      final AccountManager accountManager = AccountManager(
          accountPublicDataStorage, passwordStorage);

      //act
      Future<String> actualPassword = accountManager.getPasswordOfAccount("foo");

      //assert
      expect(actualPassword, completion("bar"));
    });

    test('AccountManager returns future error when provided storage returns future error', () async {
      //assume
      final passwordStorage = MockPasswordsStorage();
      when(passwordStorage.getPassword("foo")).thenAnswer((_) =>
          Future.error("err"));
      final accountPublicDataStorage = MockAccountPublicDataStorage();

      final AccountManager accountManager = AccountManager(accountPublicDataStorage, passwordStorage);

      try {
        //act
        String actualPassword = await accountManager.getPasswordOfAccount("foo");
        //assert
        fail("exception not thrown");
      } catch (e) {
        expect(e, "err");
      }
    });

    test("AccountManager store password to password storage under account id when adding new account",(){
      //assume
      final passwordStorage = MockPasswordsStorage();
      when(passwordStorage.storePassword(any, any)).thenAnswer((_) => Future.delayed(Duration.zero));
      final accountPublicDataStorage = MockAccountPublicDataStorage();
      when(accountPublicDataStorage.addAccount(any)).thenAnswer((_) => Future.value(AccountPublicData("id","account", "userName")));

      final AccountManager accountManager = AccountManager(accountPublicDataStorage, passwordStorage);
      final accountToAdd = AccountInputModel("account", "userName", "pass");
      //act
      accountManager.addAccount(accountToAdd);

      //expect
      verify(passwordStorage.storePassword("id", "pass"));
    });

  });
}