part of 'shift_bloc.dart';

abstract class ShiftEvent extends Equatable {
  const ShiftEvent();

  @override
  List<Object> get props => [];
}

class ShiftInitialEvent extends ShiftEvent {}

class ShiftOpenEvent extends ShiftEvent {}

class ShifCloseEvent extends ShiftEvent {}

class ShifCashInEvent extends ShiftEvent {}

class ShifCashOutEvent extends ShiftEvent {}
