import 'dart:convert';
import 'dart:io';

import 'package:check_bloc/config/constants.dart';
import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/domain/entity/cash_register.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class CashRegisterApiDataProvider {
  const CashRegisterApiDataProvider();

  Future<Either<Failure, CashRegister>> getInfo(
    String key,
    String licence,
  ) async {
    var url = Uri.parse('${AppConstants.checkboxApiServer}cash-registers/info');

    try {
      var response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          AppConstants.checkboxTokenName: 'Bearer $key',
          AppConstants.checkboxRegisterLicenseName: licence,
        },
      );
      final body = jsonDecode(utf8.decode(response.bodyBytes));
      if (response.statusCode == 200) {
        return right(CashRegister.fromJson(body));
      } else {
        return left(Failure('${body['message']}}'));
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
