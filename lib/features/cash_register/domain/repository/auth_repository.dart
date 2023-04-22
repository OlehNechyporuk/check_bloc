import 'package:check_bloc/core/failure.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  const AuthRepository();

  Future<Either<Failure, bool>> login(
    String login,
    String password,
    String cashRegisterId,
  );
  Future<void> logout(String cashRegisterId);
  Future<bool> checkAuth(String cashRegisterId);
}
