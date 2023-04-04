part of 'receipts_history_bloc.dart';

abstract class ReceiptsHistoryEvent extends Equatable {
  const ReceiptsHistoryEvent();

  @override
  List<Object> get props => [];
}

class ReceiptsHistoryLoadedEvent extends ReceiptsHistoryEvent {}
