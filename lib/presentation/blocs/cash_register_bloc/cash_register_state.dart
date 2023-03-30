// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cash_register_bloc.dart';

class CashRegisterState extends Equatable {
  final CashRegister? cashRegister;

  const CashRegisterState(this.cashRegister);

  @override
  List<Object?> get props => [cashRegister];

  CashRegisterState copyWith({
    CashRegister? cashRegister,
  }) {
    return CashRegisterState(cashRegister);
  }
}
