
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:password_keeper/business/external_interfaces/storage_interfaces.dart';

class SecurePasswordStorage implements PasswordsStorage {
  final storage = new FlutterSecureStorage();

  @override
  Future<String> getPassword(String id) async {
    return await storage.read(key: id);
  }

  @override
  Future<void> storePassword(String id, String password) async {
    await storage.write(key: id, value: password);
  }
}