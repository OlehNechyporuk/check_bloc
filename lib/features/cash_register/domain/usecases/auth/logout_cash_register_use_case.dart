import 'package:dartz/dartz.dart';

import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/core/usecases/usecase.dart';
import 'package:check_bloc/features/cash_register/domain/repository/auth_repository.dart';

class LogoutCashRegisteruseCase extends UseCase<bool, NoParams> {
  final AuthRepository _repository;

  const LogoutCashRegisteruseCase(this._repository);
  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    await _repository.logout();

    return right(true);
  }
}
