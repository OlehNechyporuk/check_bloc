part of 'cashier_bloc.dart';

abstract class CashierEvent extends Equatable {
  const CashierEvent();

  @override
  List<Object> get props => [];
}

class CashierLoadEvent extends CashierEvent {}
