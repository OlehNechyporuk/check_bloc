import 'dart:convert';
import 'dart:io';

import 'package:check_bloc/config/constants.dart';
import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/domain/entity/receipt.dart';
import 'package:check_bloc/domain/entity/receipt_payment.dart';
import 'package:check_bloc/domain/entity/shift.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class ShiftApiDataProvider {
  const ShiftApiDataProvider();

  Future<Either<Failure, Shift>> open(String apiKey, String licenceKey) async {
    var url = Uri.parse('${AppConstants.checkboxApiServer}shifts');

    try {
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          AppConstants.checkboxTokenName: 'Bearer $apiKey',
          AppConstants.checkboxRegisterLicenseName: licenceKey,
        },
      );
      final body = jsonDecode(utf8.decode(response.bodyBytes));
      if (response.statusCode == 202) {
        return right(Shift.fromJson(body));
      } else {
        return left(Failure('${body['message']}'));
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

  Future<Either<Failure, Shift>> get(String apiKey) async {
    var url = Uri.parse('${AppConstants.checkboxApiServer}cashier/shift');

    try {
      var response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          AppConstants.checkboxTokenName: 'Bearer $apiKey',
        },
      );
      final body = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200 && body != null) {
        return right(Shift.fromJson(body));
      } else {
        if (body == null) {
          return left(Failure(FailureMessages.shiftIsClosed));
        } else {
          return left(Failure('${body['message']}'));
        }
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

  Future<Either<Failure, Receipt>> close(String apiKey) async {
    var url = Uri.parse('${AppConstants.checkboxApiServer}shifts/close');

    try {
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          AppConstants.checkboxTokenName: 'Bearer $apiKey',
        },
      );

      final body = jsonDecode(utf8.decode(response.bodyBytes));
      if (response.statusCode == 202) {
        return left(Failure(FailureMessages.shiftIsClosed));
      } else {
        return left(Failure('${body['message']}'));
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

  Future<Either<Failure, Receipt>> cashReceiptService(
    String apiKey,
    ReceiptPayment payment,
  ) async {
    var url = Uri.parse('${AppConstants.checkboxApiServer}receipts/service');

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          AppConstants.checkboxTokenName: 'Bearer $apiKey',
        },
        body: jsonEncode({'payment': payment}),
      );
      final body = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 201) {
        return right(Receipt.fromJson(body));
      } else {
        return left(Failure('${body['message']}'));
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
