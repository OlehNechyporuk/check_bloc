import 'package:check_bloc/features/cash_register/data/checkbox/data_provider/checkbox_api_data_provider.dart';
import 'package:dartz/dartz.dart';

import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/features/cash_register/data/checkbox/data_provider/session_data_provider.dart';
import 'package:check_bloc/features/cash_register/domain/entity/cash_register_entity.dart';
import 'package:check_bloc/features/cash_register/domain/repository/cash_register_repository.dart';

class CashRegisterRepositoryCheckboxImpl extends CashRegisterRepository {
  final SessionDataProvider _sessionDataProvider;
  final CheckboxApiDataProvider _apiDataProvider;

  const CashRegisterRepositoryCheckboxImpl(
    this._sessionDataProvider,
    this._apiDataProvider,
  );

  @override
  Future<void> daleteLicenseKey() async {
    await _sessionDataProvider.removeRegisterKey();
  }

  @override
  Future<Either<Failure, CashRegisterEntity>> info() async {
    final apiKey = await _sessionDataProvider.apiKey();
    final String? licenceKey = await _sessionDataProvider.getRegisterKey();

    if (licenceKey == null) {
      return left(Failure('Empty licenceKey'));
    }
    return _apiDataProvider.getCashRegister(apiKey, licenceKey);
  }

  @override
  Future<String?> getLicenseKey() async {
    return await _sessionDataProvider.getRegisterKey();
  }

  @override
  Future<void> saveLicenseKey(String key) async {
    await _sessionDataProvider.saveRegisterKey(key);
  }
}
