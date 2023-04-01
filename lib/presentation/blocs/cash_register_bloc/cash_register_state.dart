part of 'cash_register_bloc.dart';

class CashRegisterState extends Equatable {
  final bool isLoading;
  final CashRegister? cashRegister;

  const CashRegisterState(
    this.isLoading,
    this.cashRegister,
  );

  @override
  List<Object?> get props => [cashRegister];

  const CashRegisterState.empty()
      : isLoading = false,
        cashRegister = null;

  CashRegisterState copyWith({
    bool? isLoading,
    CashRegister? cashRegister,
  }) {
    return CashRegisterState(
      isLoading ?? this.isLoading,
      cashRegister,
    );
  }
}
