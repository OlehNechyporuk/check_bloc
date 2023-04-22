part of 'cash_register_crm_bloc.dart';

class CashRegisterCrmState extends Equatable {
  final List<CashRegisterCrmEntity>? registers;
  final BlocStateStatus status;
  final String? errorText;
  final List<CashRegisterTypeCrmEntity>? types;

  const CashRegisterCrmState({
    required this.registers,
    required this.status,
    required this.errorText,
    required this.types,
  });

  const CashRegisterCrmState.empty()
      : registers = null,
        status = BlocStateStatus.initial,
        errorText = null,
        types = null;

  @override
  List<Object?> get props => [registers, status, errorText, types];

  CashRegisterCrmState copyWith({
    List<CashRegisterCrmEntity>? registers,
    BlocStateStatus? status,
    String? errorText,
    List<CashRegisterTypeCrmEntity>? types,
  }) {
    return CashRegisterCrmState(
      registers: registers ?? this.registers,
      status: status ?? this.status,
      errorText: errorText,
      types: types ?? this.types,
    );
  }
}
