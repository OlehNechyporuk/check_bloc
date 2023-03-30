part of 'payments_bloc.dart';

class PaymentsState extends Equatable {
  final List<ReceiptPayment> payments;

  const PaymentsState(this.payments);

  @override
  List<Object> get props => [payments];

  PaymentsState copyWith({
    List<ReceiptPayment>? payments,
  }) {
    return PaymentsState(
      payments ?? this.payments,
    );
  }
}
