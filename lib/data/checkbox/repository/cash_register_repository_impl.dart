import 'package:check_bloc/data/checkbox/data_provider/cash_register_api_data_provider.dart';
import 'package:check_bloc/data/checkbox/data_provider/session_data_provider.dart';
import 'package:check_bloc/domain/entity/cash_register.dart';
import 'package:check_bloc/domain/repository/cash_register_repository.dart';

class CashRegisterRepositoryImpl extends CashRegisterRepository {
  final SessionDataProvider _sessionDataProvider;
  final CashRegisterApiDataProvider _cashRegisterApiDataProvider;

  const CashRegisterRepositoryImpl(
      this._sessionDataProvider, this._cashRegisterApiDataProvider);

  @override
  Future<void> daleteLicenseKey() async {
    await _sessionDataProvider.removeRegisterKey();
  }

  @override
  Future<CashRegister?> getCashRegisterInfo() async {
    final String? apiKey = await _sessionDataProvider.apiKey();
    final String? licenceKey = await _sessionDataProvider.getRegisterKey();

    if (apiKey == null || licenceKey == null) {
      return null;
    }
    return _cashRegisterApiDataProvider.getInfo(apiKey, licenceKey);
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
