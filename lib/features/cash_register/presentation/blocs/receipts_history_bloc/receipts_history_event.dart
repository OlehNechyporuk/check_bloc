part of 'receipts_history_bloc.dart';

abstract class ReceiptsHistoryEvent extends Equatable {
  const ReceiptsHistoryEvent();

  @override
  List<Object> get props => [];
}

class ReceiptsHistoryLoadedEvent extends ReceiptsHistoryEvent {
  final DateTimeRange? dateRange;

  const ReceiptsHistoryLoadedEvent(this.dateRange);
}

class ReceiptsHistoryLoadedMoreEvent extends ReceiptsHistoryEvent {
  const ReceiptsHistoryLoadedMoreEvent();
}
