import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/core/usecases/usecase.dart';
import 'package:check_bloc/features/crm/domain/repository/auth_repository_crm.dart';

class LoginAuthCrmUseCase extends UseCase<String, AuthParams> {
  final AuthRepositoryCrm _authRepository;

  const LoginAuthCrmUseCase(this._authRepository);

  @override
  Future<Either<Failure, String>> call(AuthParams params) async {
    return await _authRepository.login(params.login, params.password);
  }
}

class AuthParams extends Equatable {
  final String login;
  final String password;

  const AuthParams({
    required this.login,
    required this.password,
  });

  @override
  List<Object> get props => [login, password];
}
