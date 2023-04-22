part of 'add_cash_register_crm_bloc.dart';

class AddCashRegisterCrmState extends Equatable {
  final BlocStateStatus status;
  final String? errorText;
  final CashRegisterCrmEntity? cashRegister;

  const AddCashRegisterCrmState({
    required this.status,
    required this.errorText,
    required this.cashRegister,
  });

  const AddCashRegisterCrmState.empty()
      : status = BlocStateStatus.initial,
        errorText = null,
        cashRegister = null;

  @override
  List<Object?> get props => [status, errorText, cashRegister];

  AddCashRegisterCrmState copyWith({
    BlocStateStatus? status,
    String? errorText,
    CashRegisterCrmEntity? cashRegister,
  }) {
    return AddCashRegisterCrmState(
      status: status ?? this.status,
      errorText: errorText,
      cashRegister: cashRegister,
    );
  }
}
