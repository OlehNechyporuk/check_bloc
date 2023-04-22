import 'package:dartz/dartz.dart';

import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/features/crm/domain/entity/user_entity.dart';

abstract class UserRepositoryCrm {
  const UserRepositoryCrm();

  Future<Either<Failure, UserEntity>> get();
}
