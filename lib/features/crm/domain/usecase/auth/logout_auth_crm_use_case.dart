import 'package:dartz/dartz.dart';

import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/core/usecases/usecase.dart';
import 'package:check_bloc/features/crm/domain/repository/auth_repository_crm.dart';

class LogoutAuthCrmUseCase extends UseCase<void, NoParams> {
  final AuthRepositoryCrm _authRepository;

  const LogoutAuthCrmUseCase(this._authRepository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return _authRepository.logout();
  }
}
