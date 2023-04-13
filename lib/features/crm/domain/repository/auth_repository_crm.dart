import 'package:dartz/dartz.dart';

import 'package:check_bloc/core/failure.dart';

abstract class AuthRepositoryCrm {
  const AuthRepositoryCrm();

  Future<Either<Failure, String>> login(String login, String password);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, bool>> checkAuth();
}
