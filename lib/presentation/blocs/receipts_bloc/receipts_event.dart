part of 'receipts_bloc.dart';

abstract class ReceiptsEvent extends Equatable {
  const ReceiptsEvent();

  @override
  List<Object> get props => [];
}

class ReceiptsLoadedEvent extends ReceiptsEvent {}

class ReceiptShowHtmlEvent extends ReceiptsEvent {
  final String id;

  const ReceiptShowHtmlEvent(this.id);
}
