part of 'receipts_history_bloc.dart';

class ReceiptsHistoryState extends Equatable {
  final List<ReceiptEntity>? receipts;
  final String? receiptId;
  final BlocStateStatus status;
  final String? errorText;
  final DateTimeRange dateRange;

  const ReceiptsHistoryState({
    required this.receipts,
    required this.receiptId,
    required this.status,
    required this.errorText,
    required this.dateRange,
  });

  ReceiptsHistoryState.empty()
      : receipts = null,
        receiptId = null,
        status = BlocStateStatus.initial,
        errorText = null,
        dateRange = DateTimeRange(
          start: DateTime.now(),
          end: DateTime.now(),
        );

  @override
  List<Object?> get props => [
        receipts,
        receiptId,
        status,
        errorText,
        dateRange,
      ];

  ReceiptsHistoryState copyWith({
    List<ReceiptEntity>? receipts,
    String? receiptId,
    BlocStateStatus? status,
    String? errorText,
    DateTimeRange? dateRange,
  }) {
    return ReceiptsHistoryState(
      receipts: receipts ?? this.receipts,
      receiptId: receiptId ?? this.receiptId,
      status: status ?? this.status,
      errorText: errorText ?? this.errorText,
      dateRange: dateRange ?? this.dateRange,
    );
  }
}
