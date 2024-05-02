abstract class IAuthRepository {
  Future<bool> isLoggedIn();
  Future<void> login(String email, String password);
  Future<void> logout();
  Future<void> register(String email, String password);
}
