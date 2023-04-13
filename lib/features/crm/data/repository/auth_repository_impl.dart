import 'package:check_bloc/features/crm/data/data_provider/auth_crm_provider.dart';
import 'package:dartz/dartz.dart';

import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/features/cash_register/data/checkbox/data_provider/session_data_provider.dart';
import 'package:check_bloc/features/crm/domain/repository/auth_repository_crm.dart';

class AuthRepositoryCrmImpl extends AuthRepositoryCrm {
  final AuthCrmProvider _authCrmProvider;
  final SessionDataProvider _dataProvider;

  const AuthRepositoryCrmImpl(this._authCrmProvider, this._dataProvider);

  @override
  Future<Either<Failure, bool>> checkAuth() async {
    final token = await _dataProvider.crmApiKey();

    if (token == null) {
      return left(Failure('Empty error token'));
    } else {
      return right(token.isNotEmpty);
    }
  }

  @override
  Future<Either<Failure, String>> login(
    String login,
    String password,
  ) async {
    final result = await _authCrmProvider.login(login, password);

    result.fold((error) => result, (token) async {
      await _dataProvider.saveCrmApiKey(token);
    });

    return result;
  }

  @override
  Future<Either<Failure, void>> logout() async {
    return right(await _dataProvider.removeCrmApiKey());
  }
}
