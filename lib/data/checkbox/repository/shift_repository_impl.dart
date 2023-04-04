import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/data/checkbox/data_provider/session_data_provider.dart';
import 'package:check_bloc/data/checkbox/data_provider/shift_api_data_provider.dart';
import 'package:check_bloc/domain/entity/receipt.dart';
import 'package:check_bloc/domain/entity/receipt_payment.dart';
import 'package:check_bloc/domain/entity/shift.dart';
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
  Future<Either<Failure, Receipt>> cashIn(double sum) async {
    final String? apiKey = await _sessionDataProvider.apiKey();
    if (apiKey == null) {
      return left(Failure(FailureMessages.emptyApiKey));
    }
    final payment = ReceiptPayment(
      type: 'CASH',
      value: (sum * 100).toInt(),
      label: 'Готівка',
    );

    return _apiDataProvider.cashReceiptService(apiKey, payment);
  }

  @override
  Future<Either<Failure, Receipt>> cashOut(double sum) async {
    final String? apiKey = await _sessionDataProvider.apiKey();
    if (apiKey == null) {
      return left(Failure(FailureMessages.emptyApiKey));
    }

    final payment = ReceiptPayment(
      type: 'CASH',
      value: (sum * -100).toInt(),
      label: 'Готівка',
    );

    return _apiDataProvider.cashReceiptService(apiKey, payment);
  }

  @override
  Future<Either<Failure, Receipt>> close() async {
    final String? apiKey = await _sessionDataProvider.apiKey();
    if (apiKey == null) {
      return left(Failure(FailureMessages.emptyApiKey));
    }
    return await _apiDataProvider.close(apiKey);
  }

  @override
  Future<Either<Failure, Shift>> get() async {
    final String? apiKey = await _sessionDataProvider.apiKey();
    if (apiKey == null) {
      return left(Failure(FailureMessages.emptyApiKey));
    }

    return _apiDataProvider.get(apiKey);
  }

  @override
  Future<Either<Failure, Shift>> open() async {
    final String? apiKey = await _sessionDataProvider.apiKey();
    final String? licenceKey = await _sessionDataProvider.getRegisterKey();

    if (apiKey == null || licenceKey == null) {
      return left(Failure(FailureMessages.emptyApiKey));
    }

    return _apiDataProvider.open(apiKey, licenceKey);
  }
}
