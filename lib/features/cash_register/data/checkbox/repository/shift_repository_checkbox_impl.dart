import 'package:check_bloc/features/cash_register/data/checkbox/data_provider/checkbox_api_data_provider.dart';
import 'package:dartz/dartz.dart';

import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/features/cash_register/data/checkbox/data_provider/session_data_provider.dart';
import 'package:check_bloc/features/cash_register/data/checkbox/models/receipt_payment_model.dart';
import 'package:check_bloc/features/cash_register/domain/entity/receipt_entity.dart';
import 'package:check_bloc/features/cash_register/domain/entity/shift_entity.dart';
import 'package:check_bloc/features/cash_register/domain/repository/shift_repository.dart';
import 'package:flutter/src/material/date.dart';

class ShiftRepositoryCheckboxImpl extends ShiftRepository {
  final SessionDataProvider _sessionDataProvider;
  final CheckboxApiDataProvider _apiDataProvider;

  const ShiftRepositoryCheckboxImpl(
    this._sessionDataProvider,
    this._apiDataProvider,
  );

  @override
  Future<Either<Failure, ReceiptEntity>> cashIn(double sum) async {
    final apiKey = await _sessionDataProvider.apiKey();

    final payment = ReceiptPaymentModel(
      type: 'CASH',
      value: (sum * 100).toInt(),
      label: 'Готівка',
    );

    return _apiDataProvider.cashReceiptService(apiKey, payment);
  }

  @override
  Future<Either<Failure, ReceiptEntity>> cashOut(double sum) async {
    final apiKey = await _sessionDataProvider.apiKey();

    final payment = ReceiptPaymentModel(
      type: 'CASH',
      value: (sum * -100).toInt(),
      label: 'Готівка',
    );

    return _apiDataProvider.cashReceiptService(apiKey, payment);
  }

  @override
  Future<Either<Failure, ShiftEntity>> close() async {
    final apiKey = await _sessionDataProvider.apiKey();

    return await _apiDataProvider.closeShift(apiKey);
  }

  @override
  Future<Either<Failure, ShiftEntity>> get() async {
    final apiKey = await _sessionDataProvider.apiKey();

    return _apiDataProvider.getShift(apiKey);
  }

  @override
  Future<Either<Failure, ShiftEntity>> open() async {
    final apiKey = await _sessionDataProvider.apiKey();
    final String? licenceKey = await _sessionDataProvider.getRegisterKey();

    if (licenceKey == null) {
      return left(Failure(FailureMessages.emptyApiKey));
    }

    return _apiDataProvider.openShift(apiKey, licenceKey);
  }

  @override
  Future<Either<Failure, List<ShiftEntity>>> shifts(
    DateTimeRange dateTimeRange,
    int limit,
    int offset,
  ) async {
    final apiKey = await _sessionDataProvider.apiKey();

    return _apiDataProvider.getShifts(apiKey, dateTimeRange, 25, offset);
  }
}
