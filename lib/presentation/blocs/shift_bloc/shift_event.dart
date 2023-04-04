part of 'shift_bloc.dart';

abstract class ShiftEvent extends Equatable {
  const ShiftEvent();

  @override
  List<Object> get props => [];
}

class ShiftInitialEvent extends ShiftEvent {}

class ShiftOpenEvent extends ShiftEvent {}

class ShifCloseEvent extends ShiftEvent {}

class ShifCashInEvent extends ShiftEvent {
  final double? sum;

  const ShifCashInEvent(this.sum);
}

class ShifCashOutEvent extends ShiftEvent {
  final double? sum;

  const ShifCashOutEvent(this.sum);
}
