part of 'cash_register_crm_bloc.dart';

abstract class CashRegisterCrmEvent extends Equatable {
  const CashRegisterCrmEvent();

  @override
  List<Object> get props => [];
}

class CashRegisterCrmLoadedListEvent extends CashRegisterCrmEvent {}

class CashRegisterCrmLoadedTypesListEvent extends CashRegisterCrmEvent {}
