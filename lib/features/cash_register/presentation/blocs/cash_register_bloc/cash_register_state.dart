part of 'cash_register_bloc.dart';

class CashRegisterState extends Equatable {
  final CashRegisterEntity? cashRegister;
  final BlocStateStatus status;
  final String? errorText;

  const CashRegisterState({
    required this.cashRegister,
    required this.status,
    required this.errorText,
  });

  @override
  List<Object?> get props => [cashRegister, status, errorText];

  const CashRegisterState.empty()
      : cashRegister = null,
        status = BlocStateStatus.initial,
        errorText = null;

  CashRegisterState copyWith({
    CashRegisterEntity? cashRegister,
    BlocStateStatus? status,
    String? errorText,
  }) {
    return CashRegisterState(
      cashRegister: cashRegister,
      status: status ?? this.status,
      errorText: errorText ?? this.errorText,
    );
  }
}
