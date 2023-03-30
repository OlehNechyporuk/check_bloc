import 'dart:convert';

import 'package:check_bloc/config/constants.dart';
import 'package:http/http.dart' as http;

abstract class AuthApiProviderError {}

class AuthApiProviderIncorectLoginDataError extends AuthApiProviderError {
  final String? _message;
  AuthApiProviderIncorectLoginDataError(this._message);

  String? get msg => _message;
}

class AuthApiProvider {
  const AuthApiProvider();
  Future<String> login(String login, String password) async {
    var url = Uri.parse('${AppConstants.checkboxApiServer}cashier/signin');

    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'login': login, 'password': password}),
    );

    final body = json.decode(utf8.decode(response.bodyBytes));

    if (response.statusCode == 200) {
      return body['access_token'];
    } else {
      throw AuthApiProviderIncorectLoginDataError(body['message']);
    }
  }

  Future<void> logout(String key) async {
    var url = Uri.parse('${AppConstants.checkboxApiServer}cashier/signout');

    await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        AppConstants.checkboxTokenName: 'Bearer $key',
      },
    );
  }
}
