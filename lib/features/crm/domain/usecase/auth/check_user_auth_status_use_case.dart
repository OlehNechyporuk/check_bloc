import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/core/usecases/usecase.dart';

import 'package:check_bloc/features/crm/domain/repository/auth_repository_crm.dart';
import 'package:dartz/dartz.dart';

class CheckUserAuthStatusUseCase extends UseCase<bool, NoParams> {
  final AuthRepositoryCrm _authRepository;

  const CheckUserAuthStatusUseCase(this._authRepository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await _authRepository.checkAuth();
  }
}
