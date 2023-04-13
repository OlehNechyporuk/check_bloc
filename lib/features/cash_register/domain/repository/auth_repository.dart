import 'package:check_bloc/core/failure.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  const AuthRepository();

  Future<Either<Failure, bool>> login(String login, String password);
  Future<void> logout();
  Future<bool> checkAuth();
}
