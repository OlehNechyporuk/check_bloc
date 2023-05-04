import 'package:check_bloc/features/cash_register/data/checkbox/data_provider/checkbox_api_data_provider.dart';
import 'package:dartz/dartz.dart';

import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/features/cash_register/data/checkbox/data_provider/session_data_provider.dart';
import 'package:check_bloc/features/cash_register/domain/entity/receipt_entity.dart';
import 'package:check_bloc/features/cash_register/domain/repository/receipt_repository.dart';
import 'package:flutter/material.dart';

class ReceiptRepositoryCheckboxImpl extends ReceiptRepository {
  final SessionDataProvider _sessionDataProvider;
  final CheckboxApiDataProvider _apiProvider;

  const ReceiptRepositoryCheckboxImpl(
    this._sessionDataProvider,
    this._apiProvider,
  );

  @override
  Future<Either<Failure, ReceiptEntity>> add(ReceiptEntity receipt) async {
    final apiKey = await _sessionDataProvider.apiKey();
    return _apiProvider.add(apiKey, receipt);
  }

  @override
  Future<Either<Failure, List<ReceiptEntity>>> receipts({
    required DateTimeRange? dateTimeRange,
  }) async {
    final apiKey = await _sessionDataProvider.apiKey();
    return _apiProvider.receipts(apiKey, dateTimeRange);
  }

  @override
  Future<Either<Failure, bool>> sendEmail(
    String receiptId,
    String email,
  ) async {
    final apiKey = await _sessionDataProvider.apiKey();

    return _apiProvider.sendEmail(apiKey, receiptId, email);
  }

  @override
  Future<Either<Failure, bool>> sendSms(
    String receiptId,
    String phone,
  ) async {
    final apiKey = await _sessionDataProvider.apiKey();

    return _apiProvider.sendSms(apiKey, receiptId, phone);
  }
}
