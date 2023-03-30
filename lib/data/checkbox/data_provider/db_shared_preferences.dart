import 'package:shared_preferences/shared_preferences.dart';

class DbSharedPreferences {
  SharedPreferences? _prefs;

  DbSharedPreferences() {
    load();
  }

  load() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> saveString(String key, String value) async {
    _prefs?.setString(key, value);
  }

  Future<String?> getString(String key) async {
    return _prefs?.getString(key);
  }

  Future<void> removeString(String key) async {
    _prefs?.remove(key);
  }
}
