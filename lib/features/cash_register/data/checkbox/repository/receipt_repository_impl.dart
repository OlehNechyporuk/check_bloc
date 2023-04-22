import 'package:dartz/dartz.dart';

import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/features/cash_register/data/checkbox/data_provider/receipt_api_provider.dart';
import 'package:check_bloc/features/cash_register/data/checkbox/data_provider/session_data_provider.dart';
import 'package:check_bloc/features/cash_register/domain/entity/receipt_entity.dart';
import 'package:check_bloc/features/cash_register/domain/repository/receipt_repository.dart';

class ReceiptRepositoryImpl extends ReceiptRepository {
  final SessionDataProvider _sessionDataProvider;
  final ReceiptApiProvider _apiProvider;

  const ReceiptRepositoryImpl(this._sessionDataProvider, this._apiProvider);

  @override
  Future<Either<Failure, ReceiptEntity>> add(ReceiptEntity receipt) async {
    final String? apiKey = await _sessionDataProvider.apiKey('todo');
    if (apiKey == null) {
      return left(Failure(FailureMessages.emptyApiKey));
    }

    return _apiProvider.add(apiKey, receipt);
  }

  @override
  Future<Either<Failure, List<ReceiptEntity>>> receipts() async {
    final String? apiKey = await _sessionDataProvider.apiKey('todo');
    if (apiKey == null) {
      return left(Failure(FailureMessages.emptyApiKey));
    }

    return _apiProvider.receipts(apiKey);
  }

  @override
  Future<Either<Failure, bool>> sendEmail(
    String receiptId,
    String email,
  ) async {
    final String? apiKey = await _sessionDataProvider.apiKey('todo');
    if (apiKey == null) {
      return left(Failure(FailureMessages.emptyApiKey));
    }

    return _apiProvider.sendEmail(apiKey, receiptId, email);
  }

  @override
  Future<Either<Failure, bool>> sendSms(
    String receiptId,
    String phone,
  ) async {
    final String? apiKey = await _sessionDataProvider.apiKey('todo');
    if (apiKey == null) {
      return left(Failure(FailureMessages.emptyApiKey));
    }

    return _apiProvider.sendSms(apiKey, receiptId, phone);
  }
}
