part of 'receipt_bloc.dart';

abstract class ReceiptEvent extends Equatable {
  const ReceiptEvent();

  @override
  List<Object> get props => [];
}

class ReceiptInitialEvent extends ReceiptEvent {}

class ReceiptAddGoodEvent extends ReceiptEvent {
  final ProductEntity product;

  const ReceiptAddGoodEvent(this.product);
}

class ReceiptUpdateGoodPriceEvent extends ReceiptEvent {
  final double? price;

  const ReceiptUpdateGoodPriceEvent(this.price);
}

class ReceiptUpdateQuantityEvent extends ReceiptEvent {
  final int? quantity;
  final int? index;

  const ReceiptUpdateQuantityEvent({this.quantity, required this.index});
}

class ReceiptDeleteItemEvent extends ReceiptEvent {
  final int index;
  const ReceiptDeleteItemEvent(this.index);
}

class ReceiptClearItemsEvent extends ReceiptEvent {}

class ReceiptAddDiscountToProductEvent extends ReceiptEvent {
  final int index;
  final double? discount;
  final DiscountType type;

  const ReceiptAddDiscountToProductEvent({
    required this.index,
    required this.discount,
    required this.type,
  });
}

class ReceiptAddGeneralDiscountEvent extends ReceiptEvent {
  final double? discount;
  final DiscountType? type;

  const ReceiptAddGeneralDiscountEvent({
    this.discount,
    this.type,
  });
}

class ReceiptChangePaymentEvent extends ReceiptEvent {
  final String type;
  final int? sum;

  const ReceiptChangePaymentEvent(this.type, this.sum);
}

class ReceiptAddEvent extends ReceiptEvent {}

class ReceiptAddGoodByBarcodeEvent extends ReceiptEvent {
  final String? barcode;

  const ReceiptAddGoodByBarcodeEvent(this.barcode);
}
