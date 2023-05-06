part of 'shifts_history_bloc.dart';

abstract class ShiftsHistoryEvent extends Equatable {
  const ShiftsHistoryEvent();

  @override
  List<Object> get props => [];
}

class ShiftsHistoryLoadedEvent extends ShiftsHistoryEvent {}

class ShiftsHistoryLoadedReportEvent extends ShiftsHistoryEvent {
  final String id;

  const ShiftsHistoryLoadedReportEvent(this.id);
}
