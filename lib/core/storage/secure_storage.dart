import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static final _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );

  /// Save a string value securely
  static Future<void> setString(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  /// Get a string value securely
  static Future<String?> getString(String key) async {
    return await _storage.read(key: key);
  }

  /// Delete a specific key from storage
  static Future<void> remove(String key) async {
    await _storage.delete(key: key);
  }

  /// Clear all stored data (Use with caution)
  static Future<void> clear() async {
    await _storage.deleteAll();
  }
}
