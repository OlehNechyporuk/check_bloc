import 'package:check_bloc/data/checkbox/data_provider/session_data_provider.dart';
import 'package:check_bloc/data/checkbox/data_provider/shift_api_data_provider.dart';
import 'package:check_bloc/domain/entity/receipt_payment.dart';
import 'package:check_bloc/domain/entity/shift.dart';
import 'package:check_bloc/domain/repository/shift_repository.dart';

class ShiftRepositoryImpl extends ShiftRepository {
  final SessionDataProvider _sessionDataProvider;
  final ShiftApiDataProvider _apiDataProvider;

  const ShiftRepositoryImpl(
    this._sessionDataProvider,
    this._apiDataProvider,
  );

  @override
  Future<void> cashIn(double sum) async {
    final String? apiKey = await _sessionDataProvider.apiKey();
    if (apiKey == null) {
      return;
    }
    final payment = ReceiptPayment(
      type: 'CASH',
      value: (sum * 100).toInt(),
      label: 'Готівка',
    );

    await _apiDataProvider.cashReceiptService(apiKey, payment);
  }

  @override
  Future<void> cashOut(double sum) async {
    final String? apiKey = await _sessionDataProvider.apiKey();
    if (apiKey == null) {
      return;
    }

    final payment = ReceiptPayment(
      type: 'CASH',
      value: (sum * -100).toInt(),
      label: 'Готівка',
    );

    await _apiDataProvider.cashReceiptService(apiKey, payment);
  }

  @override
  Future<void> close() async {
    final String? apiKey = await _sessionDataProvider.apiKey();
    if (apiKey != null) {
      await _apiDataProvider.close(apiKey);
    }
  }

  @override
  Future<Shift?> get() async {
    final String? apiKey = await _sessionDataProvider.apiKey();
    if (apiKey == null) {
      return null;
    }

    return _apiDataProvider.get(apiKey);
  }

  @override
  Future<Shift?> open() async {
    final String? apiKey = await _sessionDataProvider.apiKey();
    final String? licenceKey = await _sessionDataProvider.getRegisterKey();

    if (apiKey == null || licenceKey == null) {
      return null;
    }

    return _apiDataProvider.open(apiKey, licenceKey);
  }
}
