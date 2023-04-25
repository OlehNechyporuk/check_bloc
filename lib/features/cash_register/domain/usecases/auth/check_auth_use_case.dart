import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/core/usecases/usecase.dart';
import 'package:check_bloc/features/cash_register/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class CheckAuthCashRegisterUseCase extends UseCase<bool, NoParams> {
  final AuthRepository _repository;

  const CheckAuthCashRegisterUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    final result = await _repository.checkAuth();

    return result ? right(result) : left(Failure(FailureMessages.unauthorized));
  }
}
