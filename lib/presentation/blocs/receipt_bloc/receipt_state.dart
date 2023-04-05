part of 'receipt_bloc.dart';

class ReceiptState extends Equatable {
  final Receipt? receipt;
  final double? productPrice;
  final double? productQuantity;
  final BlocStateStatus status;
  final String? errorText;
  final String? lastReceiptId;

  const ReceiptState({
    required this.receipt,
    required this.productPrice,
    required this.productQuantity,
    required this.status,
    required this.errorText,
    required this.lastReceiptId,
  });

  const ReceiptState.empty()
      : receipt = const Receipt(
          payments: [
            ReceiptPayment(
              label: 'Готівка',
              type: 'CASH',
            )
          ],
          goods: [],
          discounts: [],
          bonuses: [],
          rounding: true,
        ),
        productPrice = null,
        productQuantity = null,
        status = BlocStateStatus.initial,
        errorText = null,
        lastReceiptId = null;

  @override
  List<Object?> get props => [
        receipt,
        productPrice,
        productQuantity,
        status,
        errorText,
        lastReceiptId
      ];

  ReceiptState copyWith({
    Receipt? receipt,
    double? productPrice,
    double? productQuantity,
    BlocStateStatus? status,
    String? errorText,
    String? lastReceiptId,
  }) {
    return ReceiptState(
      receipt: receipt ?? this.receipt,
      productPrice: productPrice,
      productQuantity: productQuantity,
      status: status ?? this.status,
      errorText: errorText,
      lastReceiptId: lastReceiptId,
    );
  }
}
