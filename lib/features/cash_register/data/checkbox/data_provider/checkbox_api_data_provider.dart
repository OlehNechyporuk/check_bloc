import 'dart:convert';
import 'dart:io';

import 'package:check_bloc/features/cash_register/data/checkbox/models/receipt_model.dart';
import 'package:check_bloc/features/cash_register/data/checkbox/models/receipt_payment_model.dart';
import 'package:check_bloc/features/cash_register/data/checkbox/models/shift_model.dart';
import 'package:check_bloc/features/cash_register/domain/entity/receipt_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:check_bloc/config/constants.dart';
import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/features/cash_register/data/checkbox/models/cash_register_model.dart';
import 'package:check_bloc/features/cash_register/data/checkbox/models/cashier_model.dart';
import 'package:check_bloc/features/cash_register/data/checkbox/models/product_model.dart';

class CheckboxApiDataProvider {
  final http.Client _client;

  const CheckboxApiDataProvider(this._client);

  Future<Either<Failure, String>> login(String login, String password) async {
    final url = Uri.parse('${AppConstants.checkboxApiServer}cashier/signin');
    final result = await _postRequest(
      url: url,
      params: jsonEncode({'login': login, 'password': password}),
    );

    return result.fold((error) {
      return left(error);
    }, (response) {
      final body = json.decode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        return right(body['access_token']);
      } else {
        return left(
          Failure(body['message'] ?? FailureMessages.noServerResponseMessage),
        );
      }
    });
  }

  Future<void> logout(String key) async {
    final url = Uri.parse('${AppConstants.checkboxApiServer}cashier/signout');
    await _getRequest(url: url);
  }

  Future<Either<Failure, CashRegisterModel>> getCashRegister(
    String key,
    String licence,
  ) async {
    final url =
        Uri.parse('${AppConstants.checkboxApiServer}cash-registers/info');

    final result = await _getRequest(url: url, key: key, licence: licence);

    return result.fold((error) => left(error), (result) {
      final body = jsonDecode(utf8.decode(result.bodyBytes));
      if (result.statusCode == 200) {
        return right(CashRegisterModel.fromJson(body));
      } else {
        return left(Failure('${body['message']}}'));
      }
    });
  }

  Future<Either<Failure, CashierModel>> getCashier(String key) async {
    final url = Uri.parse('${AppConstants.checkboxApiServer}cashier/me');

    final result = await _getRequest(url: url, key: key);

    return result.fold((l) => left(l), (response) {
      final body = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        return right(CashierModel.fromJson(body));
      } else {
        return left(
          Failure(
            body['message'] ?? FailureMessages.noServerResponseMessage,
          ),
        );
      }
    });
  }

  Future<Either<Failure, List<ProductModel>>> getProudcts({
    required String key,
    int limit = AppConstants.productsLimitPerPage,
    int offest = 0,
    String? query,
  }) async {
    var params = '?limit=$limit&offset=$offest';

    if (query != null && query.isNotEmpty) {
      params += '&query=$query';
    }

    final url = Uri.parse('${AppConstants.checkboxApiServer}goods$params');
    final result = await _getRequest(url: url, key: key);

    return result.fold((l) => left(l), (response) {
      final body = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        final jsonProducts = body['results'] as List;

        final result = jsonProducts.map((e) {
          return ProductModel.fromJson(e);
        });

        return right(result.toList());
      } else {
        return left(
          Failure(body['message'] ?? FailureMessages.noServerResponseMessage),
        );
      }
    });
  }

  Future<Either<Failure, ReceiptEntity>> add(
    String key,
    ReceiptEntity receipt,
  ) async {
    final url = Uri.parse('${AppConstants.checkboxApiServer}receipts/sell');
    final result = await _postRequest(
      url: url,
      key: key,
      params: jsonEncode(receipt),
    );

    return result.fold((l) => left(l), (response) {
      final body = jsonDecode(utf8.decode(response.bodyBytes));
      if (response.statusCode == 201) {
        return right(ReceiptModel.fromJson(body));
      } else {
        return left(Failure('${body['message']}'));
      }
    });
  }

  Future<Either<Failure, List<ReceiptModel>>> receipts(
    String key,
    DateTimeRange? dateTimeRange,
  ) async {
    final url = Uri.parse(
      '${AppConstants.checkboxApiServer}receipts/search/?&desc=true&from_date=${dateTimeRange?.start.toLocal()}&to_date=${dateTimeRange?.end.toLocal()}&limit=2',
    );

    final result = await _getRequest(url: url, key: key);

    return result.fold((l) => left(l), (response) {
      final body = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        final jsonReceipts = body['results'] as List;

        final result = jsonReceipts.map((e) {
          return ReceiptModel.fromJson(e);
        });

        return right(result.toList());
      } else {
        return left(Failure('${body['message']}'));
      }
    });
  }

  Future<Either<Failure, bool>> sendEmail(
    String key,
    String receiptId,
    String email,
  ) async {
    final url =
        Uri.parse('${AppConstants.checkboxApiServer}receipts/$receiptId/email');

    final result =
        await _postRequest(url: url, key: key, params: jsonEncode([email]));

    return result.fold((l) => left(l), (response) {
      final body = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        return right(true);
      } else {
        return left(Failure('${body['message']}'));
      }
    });
  }

  Future<Either<Failure, bool>> sendSms(
    String key,
    String receiptId,
    String phone,
  ) async {
    final url =
        Uri.parse('${AppConstants.checkboxApiServer}receipts/$receiptId/sms');

    final result = await _postRequest(
      url: url,
      key: key,
      params: jsonEncode({'phone': phone}),
    );

    return result.fold((l) => left(l), (response) {
      final body = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        return right(true);
      } else {
        return left(Failure('${body['message']}'));
      }
    });
  }

  Future<Either<Failure, ShiftModel>> openShift(
    String apiKey,
    String licenceKey,
  ) async {
    final url = Uri.parse('${AppConstants.checkboxApiServer}shifts');

    final result =
        await _postRequest(url: url, key: apiKey, licence: licenceKey);

    return result.fold((l) => left(l), (response) {
      final body = jsonDecode(utf8.decode(response.bodyBytes));
      if (response.statusCode == 202) {
        return right(ShiftModel.fromJson(body));
      } else {
        return left(Failure('${body['message']}'));
      }
    });
  }

  Future<Either<Failure, ShiftModel>> getShift(String apiKey) async {
    final url = Uri.parse('${AppConstants.checkboxApiServer}cashier/shift');

    final result = await _getRequest(url: url, key: apiKey);

    return result.fold((l) => left(l), (response) {
      final body = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200 && body != null) {
        return right(ShiftModel.fromJson(body));
      } else {
        if (body == null) {
          return left(Failure(FailureMessages.shiftIsClosed));
        } else {
          return left(Failure('${body['message']}'));
        }
      }
    });
  }

  Future<Either<Failure, ReceiptModel>> closeShift(String apiKey) async {
    final url = Uri.parse('${AppConstants.checkboxApiServer}shifts/close');

    final result = await _postRequest(url: url, key: apiKey);

    return result.fold((l) => left(l), (response) {
      final body = jsonDecode(utf8.decode(response.bodyBytes));
      if (response.statusCode == 202) {
        return left(Failure(FailureMessages.shiftIsClosed));
      } else {
        return left(Failure('${body['message']}'));
      }
    });
  }

  Future<Either<Failure, ReceiptModel>> cashReceiptService(
    String apiKey,
    ReceiptPaymentModel payment,
  ) async {
    final url = Uri.parse('${AppConstants.checkboxApiServer}receipts/service');

    final result = await _postRequest(
      url: url,
      key: apiKey,
      params: jsonEncode({'payment': payment}),
    );

    return result.fold((l) => left(l), (response) {
      final body = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 201) {
        return right(ReceiptModel.fromJson(body));
      } else {
        return left(Failure('${body['message']}'));
      }
    });
  }

  Future<Either<Failure, http.Response>> _getRequest({
    required Uri url,
    String? key,
    String? licence,
  }) async {
    try {
      final response = await _client.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          key == null ? '' : AppConstants.checkboxTokenName: 'Bearer $key',
          licence == null ? '' : AppConstants.checkboxRegisterLicenseName:
              '$licence',
        },
      );
      return right(response);
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

  Future<Either<Failure, http.Response>> _postRequest({
    required Uri url,
    String? key,
    String? licence,
    String? params,
  }) async {
    try {
      final response = await _client.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          key == null ? '' : AppConstants.checkboxTokenName: 'Bearer $key',
          licence == null ? '' : AppConstants.checkboxRegisterLicenseName:
              '$licence',
        },
        body: params ?? '',
      );
      return right(response);
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
