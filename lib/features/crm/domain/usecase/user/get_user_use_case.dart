import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/core/usecases/usecase.dart';
import 'package:check_bloc/features/crm/domain/entity/user_entity.dart';
import 'package:check_bloc/features/crm/domain/repository/user_repository_crm.dart';
import 'package:dartz/dartz.dart';

class GetUserUseCase extends UseCase<UserEntity, NoParams> {
  final UserRepositoryCrm _userRepositoryCrm;

  const GetUserUseCase(this._userRepositoryCrm);

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    return await _userRepositoryCrm.get();
  }
}
