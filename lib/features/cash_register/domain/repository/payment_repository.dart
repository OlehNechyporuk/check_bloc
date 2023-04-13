import 'package:check_bloc/features/cash_register/domain/entity/receipt_payment_entity.dart';

abstract class PaymentRepository {
  const PaymentRepository();

  Future<List<ReceiptPaymentEntity>> getPayments();

  Future<void> addPayment(ReceiptPaymentEntity payment);
  Future<void> deletePayment(ReceiptPaymentEntity payment);
}
