part of 'shift_bloc.dart';

class ShiftState extends Equatable {
  final ShiftEntity? shift;
  final BlocStateStatus status;
  final String? errorText;
  final String? zReportId;

  const ShiftState({
    required this.shift,
    required this.status,
    required this.errorText,
    required this.zReportId,
  });

  const ShiftState.empty()
      : shift = null,
        status = BlocStateStatus.initial,
        errorText = null,
        zReportId = null;

  @override
  List<Object?> get props => [shift, status, errorText, zReportId];

  ShiftState copyWith({
    ShiftEntity? shift,
    BlocStateStatus? status,
    String? errorText,
    String? zReportId,
  }) {
    return ShiftState(
      shift: shift,
      status: status ?? this.status,
      errorText: errorText,
      zReportId: zReportId,
    );
  }
}
