import 'package:bahaso_mobile_app/core/common/constants.dart';
import 'package:bahaso_mobile_app/data/sources/local/entities/entities.dart';
import 'package:hive/hive.dart';

class AuthDatabase {
  static const String _authBox = 'auth';
  static Future<AuthDatabase> instance() async {
    await Hive.openBox(_authBox);
    return AuthDatabase();
  }

  static const String _tokenKey = 'token';
  static const String _emailKey = 'email';

  Future<void> saveAuth(AuthEntity entity) async {
    // Save Auth to local storage
    final box = Hive.box(_authBox);
    await box.put(_tokenKey, entity.token);
    await box.put(_emailKey, entity.email);
  }

  Future<void> clearAuth() async {
    // Clear Auth from local storage
    final box = Hive.box(_authBox);
    await box.clear();
  }

  Future<AuthEntity?> getAuth() async {
    // Get Auth from local storage
    final box = Hive.box(_authBox);
    final token = box.get(_tokenKey);
    final email = box.get(_emailKey);

    logger.d('getAuth: token: $token, email: $email');

    if (token == null) {
      return null;
    }
    return AuthEntity(token: token, email: email);
  }
}
