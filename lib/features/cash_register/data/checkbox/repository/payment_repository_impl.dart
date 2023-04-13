import 'dart:convert';

import 'package:check_bloc/features/cash_register/data/checkbox/data_provider/db_shared_preferences.dart';
import 'package:check_bloc/features/cash_register/domain/entity/receipt_payment_entity.dart';
import 'package:check_bloc/features/cash_register/domain/repository/payment_repository.dart';

abstract class PaymentDbKeys {
  static const _payments = 'db_payments_key';
}

enum PaymentType { cash, card, cashless }

const _defaultPayments = [
  ReceiptPaymentEntity(label: 'Готівка', type: 'CASH', value: null),
  ReceiptPaymentEntity(label: 'Картка', type: 'CARD', value: null),
];

class PaymentRepositoryImpl extends PaymentRepository {
  final DbSharedPreferences _dataProvider;

  const PaymentRepositoryImpl(this._dataProvider);

  @override
  Future<List<ReceiptPaymentEntity>> getPayments() async {
    String? jsonPayments =
        await _dataProvider.getString(PaymentDbKeys._payments);

    if (jsonPayments != null) {
      if (jsonPayments.isNotEmpty) {}
    }

    return [..._defaultPayments];
  }

  @override
  Future<void> addPayment(ReceiptPaymentEntity payment) async {
    final payments = [];

    payments.add(payment);

    await _dataProvider.saveString(
      PaymentDbKeys._payments,
      jsonEncode(payments),
    );
  }

  @override
  Future<void> deletePayment(ReceiptPaymentEntity payment) async {}

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
