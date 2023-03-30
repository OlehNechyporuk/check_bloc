import 'package:check_bloc/domain/entity/receipt_payment.dart';

abstract class PaymetnRepository {
  const PaymetnRepository();

  Future<List<ReceiptPayment>> getPayments();

  Future<void> addPayment(ReceiptPayment payment);
  Future<void> deletePayment(ReceiptPayment payment);
}
