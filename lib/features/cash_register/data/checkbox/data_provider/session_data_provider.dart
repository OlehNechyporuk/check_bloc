import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class SessionDataProviderKeys {
  static const _apiKey = 'api_access_token';
  static const _registerKey = 'checkbox_register_key';

  static const _crmApiKey = 'crm_api_access_token';
}

class SessionDataProvider {
  final FlutterSecureStorage _storage;

  const SessionDataProvider(this._storage);

  Future<String?> apiKey(String cashRegisterId) async {
    return await _storage.read(
      key: '${SessionDataProviderKeys._apiKey}_$cashRegisterId',
    );
  }

  Future<void> saveApiKey(String token, String cashRegisterId) async {
    await _storage.write(
      key: '${SessionDataProviderKeys._apiKey}_$cashRegisterId',
      value: token,
    );
  }

  Future<void> removeApiKey(String cashRegisterId) async {
    await _storage.delete(
      key: '${SessionDataProviderKeys._apiKey}_$cashRegisterId',
    );
  }

  Future<String?> getRegisterKey(String cashRegisterId) async {
    return await _storage.read(
      key: '${SessionDataProviderKeys._registerKey}_$cashRegisterId',
    );
  }

  Future<void> saveRegisterKey(String key, String cashRegisterId) async {
    await _storage.write(
        key: '${SessionDataProviderKeys._registerKey}_$cashRegisterId',
        value: key);
  }

  Future<void> removeRegisterKey(String cashRegisterId) async {
    await _storage.delete(
      key: '${SessionDataProviderKeys._registerKey}_$cashRegisterId',
    );
  }

  Future<String?> crmApiKey() async {
    return await _storage.read(key: SessionDataProviderKeys._crmApiKey);
  }

  Future<void> saveCrmApiKey(String token) async {
    await _storage.write(key: SessionDataProviderKeys._crmApiKey, value: token);
  }

  Future<void> removeCrmApiKey() async {
    await _storage.delete(key: SessionDataProviderKeys._crmApiKey);
  }
}
