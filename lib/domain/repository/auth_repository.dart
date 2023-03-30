abstract class AuthRepository {
  const AuthRepository();
  Future<bool> login(String login, String password);
  Future<void> logout();
  Future<bool> checkAuth();
}
