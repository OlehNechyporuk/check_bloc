import 'package:check_bloc/features/cash_register/data/checkbox/data_provider/session_data_provider.dart';
import 'package:check_bloc/features/crm/data/data_provider/user_crm_data_provider.dart';
import 'package:dartz/dartz.dart';

import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/features/crm/domain/entity/user_entity.dart';
import 'package:check_bloc/features/crm/domain/repository/user_repository_crm.dart';

class UserRepositoryCrmImpl extends UserRepositoryCrm {
  final UserCrmDataProvider _userCrmDataProvider;
  final SessionDataProvider _sessionDataProvider;

  const UserRepositoryCrmImpl(
    this._userCrmDataProvider,
    this._sessionDataProvider,
  );

  @override
  Future<Either<Failure, UserEntity>> get() async {
    final token = await _sessionDataProvider.crmApiKey();
    if (token == null) return left(Failure('Empty api token'));

    return await _userCrmDataProvider.get(token);
  }
}
