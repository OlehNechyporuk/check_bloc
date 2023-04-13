part of 'cash_register_bloc.dart';

abstract class CashRegisterEvent extends Equatable {
  const CashRegisterEvent();

  @override
  List<Object> get props => [];
}

class CashRegisterLoadEvent extends CashRegisterEvent {}
