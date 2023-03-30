part of 'receipt_bloc.dart';

class ReceiptState extends Equatable {
  final Receipt? receipt;
  final double? price;
  final double? quantity;

  const ReceiptState(this.receipt, this.price, this.quantity);

  @override
  List<Object?> get props => [receipt, price, quantity];

  ReceiptState copyWith({
    Receipt? receipt,
    double? price,
    double? quantity,
  }) {
    return ReceiptState(
      receipt ?? this.receipt,
      price,
      quantity,
    );
  }
}
