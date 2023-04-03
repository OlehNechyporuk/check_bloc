import 'dart:convert';
import 'dart:io';

import 'package:check_bloc/config/constants.dart';
import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/domain/entity/cashier.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class CashierApiDataProvider {
  const CashierApiDataProvider();

  Future<Either<Failure, Cashier>> getInfo(String key) async {
    var url = Uri.parse('${AppConstants.checkboxApiServer}cashier/me');
    try {
      var response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          AppConstants.checkboxTokenName: 'Bearer $key',
        },
      );

      final body = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        return right(Cashier.fromJson(body));
      } else {
        return left(
          Failure(
            body['message'] ?? FailureMessages.noServerResponseMessage,
          ),
        );
      }
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
}
