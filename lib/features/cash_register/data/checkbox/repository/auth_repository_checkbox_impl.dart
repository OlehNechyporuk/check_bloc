import 'package:check_bloc/features/cash_register/data/checkbox/data_provider/checkbox_api_data_provider.dart';
import 'package:dartz/dartz.dart';

import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/features/cash_register/data/checkbox/data_provider/session_data_provider.dart';
import 'package:check_bloc/features/cash_register/domain/repository/auth_repository.dart';

class AuthRepositoryCheckboxImpl extends AuthRepository {
  final SessionDataProvider _dataProvider;
  final CheckboxApiDataProvider _apiProvider;

  const AuthRepositoryCheckboxImpl(this._dataProvider, this._apiProvider);

  @override
  Future<bool> checkAuth() async {
    try {
      final apiKey = await _dataProvider.apiKey();
      if (apiKey.isEmpty) {
        return false;
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Either<Failure, bool>> login(
    String login,
    String password,
  ) async {
    if (login.isNotEmpty && password.isNotEmpty) {
      final result = await _apiProvider.login(login, password);

      return result.fold((error) {
        return left(error);
      }, (token) async {
        await _dataProvider.saveApiKey(token);
        return right(true);
      });
    }
    return left(Failure(FailureMessages.emptyLoginOrPassword));
  }

  @override
  Future<void> logout() async {
    await _dataProvider.removeApiKey();
  }
}
