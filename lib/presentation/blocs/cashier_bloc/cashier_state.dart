// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cashier_bloc.dart';

class CashierState extends Equatable {
  final Cashier? cashier;

  const CashierState(this.cashier);

  @override
  List<Object?> get props => [cashier];

  CashierState copyWith({
    Cashier? cashier,
  }) {
    return CashierState(
      cashier ?? this.cashier,
    );
  }
}
