import 'package:bahaso_mobile_app/core/common/exceptions/base_exception.dart';
import 'package:bahaso_mobile_app/data/sources/local/database/auth_database.dart';
import 'package:bahaso_mobile_app/domain/repositories/repositories.dart';

import '../sources/remote/services/services.dart';

class AuthRepository implements IAuthRepository {
  final AuthDatabase _authDatabase;
  final AuthService _authService;
  AuthRepository(this._authDatabase, this._authService);

  @override
  Future<bool> isLoggedIn() => _authDatabase.hasAuth();

  @override
  Future<void> login(String email, String password) async {
    final response = await _authService.login(email, password);
    if (response.token == null) {
      throw BaseException(message: 'Invalid token');
    }
    await _authDatabase.saveAuth(response.token!);
  }

  @override
  Future<void> logout() {
    return _authDatabase.clearAuth();
  }
}
