// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'shift_bloc.dart';

class ShiftState extends Equatable {
  final Shift? shift;
  final TextEditingController? cashInController;
  final TextEditingController? cashOutController;

  const ShiftState(this.shift, this.cashInController, this.cashOutController);

  @override
  List<Object?> get props => [shift, cashInController, cashOutController];

  ShiftState copyWith({
    Shift? shift,
    TextEditingController? cashInController,
    TextEditingController? cashOutController,
  }) {
    return ShiftState(
      shift,
      cashInController ?? this.cashInController,
      cashOutController ?? this.cashOutController,
    );
  }
}
