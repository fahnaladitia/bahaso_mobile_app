import '../models/models.dart';

abstract class IAuthRepository {
  Future<Auth?> getLoggedInAuth();
  Future<void> login(String email, String password);
  Future<void> logout();
  Future<void> register(String email, String password);
}
