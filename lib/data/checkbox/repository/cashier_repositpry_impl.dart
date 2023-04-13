import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/data/checkbox/data_provider/cashier_api_data_provider.dart';
import 'package:check_bloc/data/checkbox/data_provider/session_data_provider.dart';
import 'package:check_bloc/domain/entity/cashier_etity.dart';
import 'package:check_bloc/domain/repository/cashier_repository.dart';
import 'package:dartz/dartz.dart';

class CashierRepositoryImpl extends CashierRepository {
  final SessionDataProvider _sessionDataProvider;
  final CashierApiDataProvider _cashierApiDataProvider;

  const CashierRepositoryImpl(
    this._sessionDataProvider,
    this._cashierApiDataProvider,
  );

  @override
  Future<Either<Failure, CashierEntity>> info() async {
    final String? apiKey = await _sessionDataProvider.apiKey();
    if (apiKey == null) return left(Failure('Empty Api key'));
    return _cashierApiDataProvider.getInfo(apiKey);
  }
}
