part of 'cashier_bloc.dart';

class CashierState extends Equatable {
  final Cashier? cashier;
  final BlocStateStatus status;
  final String? errorText;

  const CashierState({
    required this.cashier,
    required this.status,
    this.errorText,
  });

  const CashierState.empty()
      : cashier = null,
        status = BlocStateStatus.initial,
        errorText = null;

  @override
  List<Object?> get props => [cashier, status, errorText];

  CashierState copyWith({
    Cashier? cashier,
    BlocStateStatus? status,
    String? errorText,
  }) {
    return CashierState(
      cashier: cashier ?? this.cashier,
      status: status ?? this.status,
      errorText: errorText ?? this.errorText,
    );
  }
}
