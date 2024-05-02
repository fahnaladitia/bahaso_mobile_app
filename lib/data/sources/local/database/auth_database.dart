import 'package:hive/hive.dart';

class AuthDatabase {
  static const String _authBox = 'auth';
  static Future<AuthDatabase> instance() async {
    await Hive.openBox(_authBox);
    return AuthDatabase();
  }

  static const String _tokenKey = 'token';

  Future<void> saveAuth(String token) async {
    // Save token to local storage
    final box = Hive.box(_authBox);
    await box.put(_tokenKey, token);
  }

  Future<bool> hasAuth() async {
    // Check if token exists in local storage
    final box = Hive.box(_authBox);
    final token = box.get(_tokenKey);
    return token != null;
  }

  Future<void> clearAuth() async {
    // Delete token from local storage
    final box = Hive.box(_authBox);
    await box.delete(_tokenKey);
  }
}
