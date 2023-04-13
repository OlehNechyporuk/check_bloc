part of 'payments_bloc.dart';

class PaymentsState extends Equatable {
  final List<ReceiptPaymentEntity> payments;

  const PaymentsState(this.payments);

  @override
  List<Object> get props => [payments];

  PaymentsState copyWith({
    List<ReceiptPaymentEntity>? payments,
  }) {
    return PaymentsState(
      payments ?? this.payments,
    );
  }
}
