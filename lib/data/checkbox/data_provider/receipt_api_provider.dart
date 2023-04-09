import 'dart:convert';
import 'dart:io';

import 'package:check_bloc/config/constants.dart';
import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/domain/entity/receipt.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class ReceiptApiProvider {
  const ReceiptApiProvider();

  Future<Either<Failure, Receipt>> add(String apiKey, Receipt receipt) async {
    var url = Uri.parse('${AppConstants.checkboxApiServer}receipts/sell');

    try {
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          AppConstants.checkboxTokenName: 'Bearer $apiKey',
        },
        body: jsonEncode(receipt),
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

  Future<Either<Failure, List<Receipt>>> receipts(String apiKey) async {
    var url = Uri.parse(
      '${AppConstants.checkboxApiServer}receipts/search/?&desc=true',
    );
    try {
      var response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          AppConstants.checkboxTokenName: 'Bearer $apiKey',
        },
      );

      final body = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        final jsonReceipts = body['results'] as List;

        final result = jsonReceipts.map((e) {
          return Receipt.fromJson(e);
        });

        return right(result.toList());
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

  Future<Either<Failure, bool>> sendEmail(
    String apiKey,
    String receiptId,
    String email,
  ) async {
    var url =
        Uri.parse('${AppConstants.checkboxApiServer}receipts/$receiptId/email');
    try {
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          AppConstants.checkboxTokenName: 'Bearer $apiKey',
        },
        body: jsonEncode([email]),
      );

      final body = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        return right(true);
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

  Future<Either<Failure, bool>> sendSms(
    String apiKey,
    String receiptId,
    String phone,
  ) async {
    var url =
        Uri.parse('${AppConstants.checkboxApiServer}receipts/$receiptId/sms');
    try {
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          AppConstants.checkboxTokenName: 'Bearer $apiKey',
        },
        body: jsonEncode({'phone': phone}),
      );

      final body = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        return right(true);
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
