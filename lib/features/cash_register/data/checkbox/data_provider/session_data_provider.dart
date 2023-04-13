import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class SessionDataProviderKeys {
  static const _apiKey = 'api_access_token';
  static const _registerKey = 'checkbox_register_key';

  static const _crmApiKey = 'crm_api_access_token';
}

class SessionDataProvider {
  final FlutterSecureStorage _storage;

  const SessionDataProvider(this._storage);

  Future<String?> apiKey() async {
    return await _storage.read(key: SessionDataProviderKeys._apiKey);
  }

  Future<void> saveApiKey(String token) async {
    await _storage.write(key: SessionDataProviderKeys._apiKey, value: token);
  }

  Future<void> removeApiKey() async {
    await _storage.delete(key: SessionDataProviderKeys._apiKey);
  }

  Future<String?> getRegisterKey() async {
    return await _storage.read(key: SessionDataProviderKeys._registerKey);
  }

  Future<void> saveRegisterKey(String key) async {
    await _storage.write(key: SessionDataProviderKeys._registerKey, value: key);
  }

  Future<void> removeRegisterKey() async {
    await _storage.delete(key: SessionDataProviderKeys._registerKey);
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
