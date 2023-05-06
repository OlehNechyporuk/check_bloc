import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class SessionDataProviderKeys {
  static const _apiKey = 'api_access_token';
  static const _registerKey = 'checkbox_register_key';
  static const _currentCashRegisterId = 'current_cash_register_id';

  static const _crmApiKey = 'crm_api_access_token';
}

class SessionDataProvider {
  final FlutterSecureStorage _storage;

  const SessionDataProvider(this._storage);

  Future<void> saveCurrentCashRegister(String cashRegisterId) async {
    await _storage.write(
      key: SessionDataProviderKeys._currentCashRegisterId,
      value: cashRegisterId,
    );
  }

  Future<String?> getCurrentCashRegisterId() async {
    return await _storage.read(
      key: SessionDataProviderKeys._currentCashRegisterId,
    );
  }

  Future<String> apiKey() async {
    final currentCashRegisteId = await _storage.read(
      key: SessionDataProviderKeys._currentCashRegisterId,
    );

    if (currentCashRegisteId == null) {
      throw 'Error empty current cash register';
    }

    final key = await _storage.read(
      key: '${SessionDataProviderKeys._apiKey}_$currentCashRegisteId',
    );

    if (key == null) {
      throw 'Empty api key';
    }

    return key;
  }

  Future<void> saveApiKey(String token) async {
    final currentCashRegisteId = await _storage.read(
      key: SessionDataProviderKeys._currentCashRegisterId,
    );

    if (currentCashRegisteId == null) {
      throw 'Error empty current cash register';
    }
    await _storage.write(
      key: '${SessionDataProviderKeys._apiKey}_$currentCashRegisteId',
      value: token,
    );
  }

  Future<void> removeApiKey() async {
    final currentCashRegisteId = await _storage.read(
      key: SessionDataProviderKeys._currentCashRegisterId,
    );
    if (currentCashRegisteId == null) {
      throw 'Error empty current cash register';
    }
    await _storage.delete(
      key: '${SessionDataProviderKeys._apiKey}_$currentCashRegisteId',
    );
  }

  Future<String?> getRegisterKey() async {
    final currentCashRegisteId = await _storage.read(
      key: SessionDataProviderKeys._currentCashRegisterId,
    );
    if (currentCashRegisteId == null) {
      throw 'Error empty current cash register';
    }
    return await _storage.read(
      key: '${SessionDataProviderKeys._registerKey}_$currentCashRegisteId',
    );
  }

  Future<void> saveRegisterKey(String key) async {
    final currentCashRegisteId = await _storage.read(
      key: SessionDataProviderKeys._currentCashRegisterId,
    );
    if (currentCashRegisteId == null) {
      throw 'Error empty current cash register';
    }
    await _storage.write(
      key: '${SessionDataProviderKeys._registerKey}_$currentCashRegisteId',
      value: key,
    );
  }

  Future<void> removeRegisterKey() async {
    final currentCashRegisteId = await _storage.read(
      key: SessionDataProviderKeys._currentCashRegisterId,
    );
    if (currentCashRegisteId == null) {
      throw 'Error empty current cash register';
    }
    await _storage.delete(
      key: '${SessionDataProviderKeys._registerKey}_$currentCashRegisteId',
    );
  }

  Future<String?> crmApiKey() async {
    return await _storage.read(key: SessionDataProviderKeys._crmApiKey);
  }

  Future<void> saveCrmApiKey(String token) async {
    final result = await _storage.write(
      key: SessionDataProviderKeys._crmApiKey,
      value: token,
    );
    return result;
  }

  Future<void> removeCrmApiKey() async {
    await _storage.delete(key: SessionDataProviderKeys._crmApiKey);
  }
}
