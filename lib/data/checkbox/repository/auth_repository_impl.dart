import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/data/checkbox/data_provider/auth_api_provider.dart';
import 'package:check_bloc/data/checkbox/data_provider/session_data_provider.dart';
import 'package:check_bloc/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl extends AuthRepository {
  final SessionDataProvider _dataProvider;
  final AuthApiProvider _apiProvider;

  const AuthRepositoryImpl(this._dataProvider, this._apiProvider);

  @override
  Future<bool> checkAuth() async {
    final String? apiKey = await _dataProvider.apiKey();
    if (apiKey == null || apiKey.isEmpty) {
      return false;
    }

    return true;
  }

  @override
  Future<Either<Failure, bool>> login(String login, String password) async {
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
