import 'dart:convert';

import 'package:check_bloc/data/checkbox/data_provider/db_shared_preferences.dart';
import 'package:check_bloc/domain/entity/receipt_payment.dart';
import 'package:check_bloc/domain/repository/payment_repository.dart';

abstract class PaymentDbKeys {
  static const _payments = 'db_payments_key';
}

enum PaymentType { cash, card, cashless }

const _defaultPayments = [
  ReceiptPayment(label: 'Готівка', type: 'CASH'),
  ReceiptPayment(label: 'Картка', type: 'CARD'),
];

class PaymentRepositoryImpl extends PaymetnRepository {
  final DbSharedPreferences _dataProvider;

  const PaymentRepositoryImpl(this._dataProvider);

  @override
  Future<List<ReceiptPayment>> getPayments() async {
    String? jsonPayments =
        await _dataProvider.getString(PaymentDbKeys._payments);

    if (jsonPayments != null) {
      if (jsonPayments.isNotEmpty) {}
    }

    return [..._defaultPayments];
  }

  @override
  Future<void> addPayment(ReceiptPayment payment) async {
    final paymetns = [];

    paymetns.add(payment);

    await _dataProvider.saveString(
      PaymentDbKeys._payments,
      jsonEncode(paymetns),
    );
  }

  @override
  Future<void> deletePayment(ReceiptPayment payment) async {}

  static PaymentType convertStringToEnum(type) {
    if (type == 'CASH') {
      return PaymentType.cash;
    } else if (type == 'CARD') {
      return PaymentType.card;
    } else {
      return PaymentType.cashless;
    }
  }

  static String convertEnumToString(PaymentType type) {
    if (type == PaymentType.cash) {
      return 'CASH';
    } else if (type == PaymentType.card) {
      return 'CARD';
    } else {
      return 'CASHLESS';
    }
  }
}
