part of 'receipt_delivery_bloc.dart';

abstract class ReceiptDeliveryEvent extends Equatable {
  const ReceiptDeliveryEvent();

  @override
  List<Object> get props => [];
}

class ReceiptDeliveryInitialEvent extends ReceiptDeliveryEvent {}

class ReceiptDeliverySendEmailEvent extends ReceiptDeliveryEvent {
  final String receiptId;
  final String email;

  const ReceiptDeliverySendEmailEvent(
    this.receiptId,
    this.email,
  );
}

class ReceiptDeliverySendSmsEvent extends ReceiptDeliveryEvent {
  final String receiptId;
  final String phone;

  const ReceiptDeliverySendSmsEvent(
    this.receiptId,
    this.phone,
  );
}
