import 'package:dartz/dartz.dart';

import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/features/cash_register/data/checkbox/data_provider/checkbox_api_data_provider.dart';
import 'package:check_bloc/features/cash_register/data/checkbox/data_provider/session_data_provider.dart';
import 'package:check_bloc/features/cash_register/domain/entity/cashier_etity.dart';
import 'package:check_bloc/features/cash_register/domain/repository/cashier_repository.dart';

class CashierRepositoryCheckboxImpl extends CashierRepository {
  final SessionDataProvider _sessionDataProvider;
  final CheckboxApiDataProvider _apiDataProvider;

  const CashierRepositoryCheckboxImpl(
    this._sessionDataProvider,
    this._apiDataProvider,
  );

  @override
  Future<Either<Failure, CashierEntity>> info() async {
    final apiKey = await _sessionDataProvider.apiKey();

    return _apiDataProvider.getCashier(apiKey);
  }
}
