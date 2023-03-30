import 'package:check_bloc/data/checkbox/data_provider/receipt_api_provider.dart';
import 'package:check_bloc/data/checkbox/data_provider/session_data_provider.dart';
import 'package:check_bloc/domain/entity/receipt.dart';
import 'package:check_bloc/domain/repository/receipt_repository.dart';

class ReceiptRepositoryImpl extends ReceiptRepository {
  final SessionDataProvider _sessionDataProvider;
  final ReceiptApiProvider _apiProvider;

  const ReceiptRepositoryImpl(this._sessionDataProvider, this._apiProvider);

  @override
  Future<Receipt?> add(Receipt receipt) async {
    final String? apiKey = await _sessionDataProvider.apiKey();
    if (apiKey == null) throw 'Empty Api key';

    return _apiProvider.add(apiKey, receipt);
  }

  @override
  Future<List<Receipt>?> receipts() async {
    final String? apiKey = await _sessionDataProvider.apiKey();
    if (apiKey == null) throw 'Empty Api key';
    return _apiProvider.receipts(apiKey);
  }

  @override
  Future<String?> getHtml(String id) async {
    final String? apiKey = await _sessionDataProvider.apiKey();
    if (apiKey == null) throw 'Empty Api key';
    return _apiProvider.getHtml(apiKey, id);
  }
}
