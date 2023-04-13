part of 'cash_register_form_bloc.dart';

abstract class CashRegisterFormEvent extends Equatable {
  const CashRegisterFormEvent();

  @override
  List<Object> get props => [];
}

class CashRegisterFormLoadEvent extends CashRegisterFormEvent {}

class CashRegisterFormOnchangeEvent extends CashRegisterFormEvent {
  final String? key;
  const CashRegisterFormOnchangeEvent(this.key);
}

class CashRegisterFormSubmitEvent extends CashRegisterFormEvent {}
