import 'dart:convert';
import 'dart:io';

import 'package:check_bloc/config/constants.dart';
import 'package:check_bloc/core/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class AuthCrmDataProvider {
  final http.Client _client;

  const AuthCrmDataProvider(this._client);

  Future<Either<Failure, String>> login(String login, String password) async {
    await Future.delayed(Duration(seconds: 2));
    try {
      if (login == 'admin' && password == 'admin') {
        return right('dksajdaskdjaskdj slakd asdlk aslkdl askd');
      } else {
        return left(Failure('Erorororrrr'));
      }

      // var url = Uri.parse('${AppConstants.checkboxApiServer}cashier/signin');

      // var response = await _client.post(
      //   url,
      //   headers: <String, String>{
      //     'Content-Type': 'application/json',
      //   },
      //   body: jsonEncode({'login': login, 'password': password}),
      // );

      // final body = json.decode(utf8.decode(response.bodyBytes));

      // if (response.statusCode == 200) {
      //   return right(body['access_token']);
      // } else {
      //   return left(
      //     Failure(body['message'] ?? FailureMessages.noServerResponseMessage),
      //   );
      // }
    } on SocketException {
      return left(Failure(FailureMessages.noInternetConnection));
    } on HttpException catch (e) {
      return left(Failure(e.message));
    } on FormatException {
      return left(Failure(FailureMessages.badResponseFormat));
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout(String key) async {
    var url = Uri.parse('${AppConstants.checkboxApiServer}cashier/signout');

    try {
      await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          AppConstants.checkboxTokenName: 'Bearer $key',
        },
      );
    } catch (e) {
      rethrow;
    }
  }
}
