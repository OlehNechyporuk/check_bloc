import 'package:dartz/dartz.dart';

import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/core/usecases/usecase.dart';
import 'package:check_bloc/features/cash_register/domain/repository/auth_repository.dart';

class LoginCashRegisterUseCase extends UseCase<bool, AuthCashRegisterParams> {
  final AuthRepository _repository;

  const LoginCashRegisterUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> call(AuthCashRegisterParams params) async {
    return await _repository.login(
      params.login,
      params.password,
    );
  }
}

class AuthCashRegisterParams {
  final String login;
  final String password;

  AuthCashRegisterParams(this.login, this.password);
}
