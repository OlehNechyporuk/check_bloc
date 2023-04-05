import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/data/checkbox/data_provider/receipt_api_provider.dart';
import 'package:check_bloc/data/checkbox/data_provider/session_data_provider.dart';
import 'package:check_bloc/domain/entity/receipt.dart';
import 'package:check_bloc/domain/repository/receipt_repository.dart';
import 'package:dartz/dartz.dart';

class ReceiptRepositoryImpl extends ReceiptRepository {
  final SessionDataProvider _sessionDataProvider;
  final ReceiptApiProvider _apiProvider;

  const ReceiptRepositoryImpl(this._sessionDataProvider, this._apiProvider);

  @override
  Future<Either<Failure, Receipt>> add(Receipt receipt) async {
    final String? apiKey = await _sessionDataProvider.apiKey();
    if (apiKey == null) {
      return left(Failure(FailureMessages.emptyApiKey));
    }

    return _apiProvider.add(apiKey, receipt);
  }

  @override
  Future<Either<Failure, List<Receipt>>> receipts() async {
    final String? apiKey = await _sessionDataProvider.apiKey();
    if (apiKey == null) {
      return left(Failure(FailureMessages.emptyApiKey));
    }

    return _apiProvider.receipts(apiKey);
  }
}
