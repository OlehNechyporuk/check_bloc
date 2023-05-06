part of 'shifts_history_bloc.dart';

class ShiftsHistoryState extends Equatable {
  final List<ShiftEntity> shifts;
  final BlocStateStatus status;
  final String? modalReport;
  final bool showLoadMore;
  final String? errorText;

  const ShiftsHistoryState({
    required this.shifts,
    required this.status,
    required this.modalReport,
    required this.showLoadMore,
    required this.errorText,
  });

  const ShiftsHistoryState.empty()
      : shifts = const [],
        status = BlocStateStatus.initial,
        modalReport = null,
        showLoadMore = true,
        errorText = null;

  @override
  List<Object?> get props => [
        shifts,
        status,
        modalReport,
        showLoadMore,
        errorText,
      ];

  ShiftsHistoryState copyWith({
    List<ShiftEntity>? shifts,
    BlocStateStatus? status,
    String? modalReport,
    bool? showLoadMore,
    String? errorText,
  }) {
    return ShiftsHistoryState(
      shifts: shifts ?? this.shifts,
      status: status ?? this.status,
      modalReport: modalReport ?? this.modalReport,
      showLoadMore: showLoadMore ?? this.showLoadMore,
      errorText: errorText ?? this.errorText,
    );
  }
}
