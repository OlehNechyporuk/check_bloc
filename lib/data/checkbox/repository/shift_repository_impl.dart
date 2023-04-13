import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/data/checkbox/data_provider/session_data_provider.dart';
import 'package:check_bloc/data/checkbox/data_provider/shift_api_data_provider.dart';
import 'package:check_bloc/data/checkbox/models/receipt_payment_model.dart';
import 'package:check_bloc/domain/entity/receipt_entity.dart';
import 'package:check_bloc/domain/entity/shift_entity.dart';
import 'package:check_bloc/domain/repository/shift_repository.dart';
import 'package:dartz/dartz.dart';

class ShiftRepositoryImpl extends ShiftRepository {
  final SessionDataProvider _sessionDataProvider;
  final ShiftApiDataProvider _apiDataProvider;

  const ShiftRepositoryImpl(
    this._sessionDataProvider,
    this._apiDataProvider,
  );

  @override
  Future<Either<Failure, ReceiptEntity>> cashIn(double sum) async {
    final String? apiKey = await _sessionDataProvider.apiKey();
    if (apiKey == null) {
      return left(Failure(FailureMessages.emptyApiKey));
    }
    final payment = ReceiptPaymentModel(
      type: 'CASH',
      value: (sum * 100).toInt(),
      label: 'Готівка',
    );

    return _apiDataProvider.cashReceiptService(apiKey, payment);
  }

  @override
  Future<Either<Failure, ReceiptEntity>> cashOut(double sum) async {
    final String? apiKey = await _sessionDataProvider.apiKey();
    if (apiKey == null) {
      return left(Failure(FailureMessages.emptyApiKey));
    }

    final payment = ReceiptPaymentModel(
      type: 'CASH',
      value: (sum * -100).toInt(),
      label: 'Готівка',
    );

    return _apiDataProvider.cashReceiptService(apiKey, payment);
  }

  @override
  Future<Either<Failure, ReceiptEntity>> close() async {
    final String? apiKey = await _sessionDataProvider.apiKey();
    if (apiKey == null) {
      return left(Failure(FailureMessages.emptyApiKey));
    }
    return await _apiDataProvider.close(apiKey);
  }

  @override
  Future<Either<Failure, ShiftEntity>> get() async {
    final String? apiKey = await _sessionDataProvider.apiKey();
    if (apiKey == null) {
      return left(Failure(FailureMessages.emptyApiKey));
    }

    return _apiDataProvider.get(apiKey);
  }

  @override
  Future<Either<Failure, ShiftEntity>> open() async {
    final String? apiKey = await _sessionDataProvider.apiKey();
    final String? licenceKey = await _sessionDataProvider.getRegisterKey();

    if (apiKey == null || licenceKey == null) {
      return left(Failure(FailureMessages.emptyApiKey));
    }

    return _apiDataProvider.open(apiKey, licenceKey);
  }
}
