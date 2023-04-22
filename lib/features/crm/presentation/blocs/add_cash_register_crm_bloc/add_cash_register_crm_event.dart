part of 'add_cash_register_crm_bloc.dart';

abstract class AddCashRegisterCrmEvent extends Equatable {
  const AddCashRegisterCrmEvent();

  @override
  List<Object> get props => [];
}

class AddCashRegisterAddCrmEvent extends AddCashRegisterCrmEvent {
  final String title;
  final int typeId;

  const AddCashRegisterAddCrmEvent({
    required this.title,
    required this.typeId,
  });
}
