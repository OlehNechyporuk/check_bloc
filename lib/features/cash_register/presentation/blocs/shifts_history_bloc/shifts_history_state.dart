part of 'shifts_history_bloc.dart';

class ShiftsHistoryState extends Equatable {
  final List<ShiftEntity> shifts;
  final BlocStateStatus status;
  final bool showLoadMore;
  final String? errorText;

  const ShiftsHistoryState({
    required this.shifts,
    required this.status,
    required this.showLoadMore,
    required this.errorText,
  });

  const ShiftsHistoryState.empty()
      : shifts = const [],
        status = BlocStateStatus.initial,
        showLoadMore = true,
        errorText = null;

  @override
  List<Object?> get props => [
        shifts,
        status,
        showLoadMore,
        errorText,
      ];

  ShiftsHistoryState copyWith({
    List<ShiftEntity>? shifts,
    BlocStateStatus? status,
    bool? showLoadMore,
    String? errorText,
  }) {
    return ShiftsHistoryState(
      shifts: shifts ?? this.shifts,
      status: status ?? this.status,
      showLoadMore: showLoadMore ?? this.showLoadMore,
      errorText: errorText ?? this.errorText,
    );
  }
}
