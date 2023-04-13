part of 'shift_bloc.dart';

class ShiftState extends Equatable {
  final ShiftEntity? shift;
  final BlocStateStatus status;
  final String? errorText;

  const ShiftState({
    required this.shift,
    required this.status,
    required this.errorText,
  });

  const ShiftState.empty()
      : shift = null,
        status = BlocStateStatus.initial,
        errorText = null;

  @override
  List<Object?> get props => [shift, status, errorText];

  ShiftState copyWith({
    ShiftEntity? shift,
    BlocStateStatus? status,
    String? errorText,
  }) {
    return ShiftState(
      shift: shift,
      status: status ?? this.status,
      errorText: errorText,
    );
  }
}
