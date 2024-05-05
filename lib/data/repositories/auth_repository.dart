import 'package:bahaso_mobile_app/core/common/exceptions/base_exception.dart';
import 'package:bahaso_mobile_app/data/mappers/mappers.dart';
import 'package:bahaso_mobile_app/data/sources/local/database/auth_database.dart';
import 'package:bahaso_mobile_app/data/sources/local/entities/entities.dart';
import 'package:bahaso_mobile_app/data/sources/remote/services/services.dart';
import 'package:bahaso_mobile_app/domain/models/models.dart';
import 'package:bahaso_mobile_app/domain/repositories/repositories.dart';

class AuthRepository implements IAuthRepository {
  final AuthDatabase _authDatabase;
  final AuthService _authService;
  AuthRepository(this._authDatabase, this._authService);

  @override
  Future<Auth?> getLoggedInAuth() async {
    final auth = await _authDatabase.getAuth();

    return auth?.toModel();
  }

  @override
  Future<void> login(String email, String password) async {
    final response = await _authService.login(email, password);
    if (response.token == null) {
      throw BaseException(message: 'Invalid token');
    }
    await _authDatabase.saveAuth(AuthEntity(token: response.token, email: email));
  }

  @override
  Future<void> logout() {
    return _authDatabase.clearAuth();
  }

  @override
  Future<void> register(String email, String password) async {
    await _authService.register(email, password);
  }
}
