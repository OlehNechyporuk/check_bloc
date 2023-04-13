part of 'receipts_history_bloc.dart';

class ReceiptsHistoryState extends Equatable {
  final List<ReceiptEntity>? receipts;
  final String? receiptId;
  final BlocStateStatus status;
  final String? errorText;

  const ReceiptsHistoryState({
    required this.receipts,
    required this.receiptId,
    required this.status,
    required this.errorText,
  });

  const ReceiptsHistoryState.empty()
      : receipts = null,
        receiptId = null,
        status = BlocStateStatus.initial,
        errorText = null;

  @override
  List<Object?> get props => [receipts, receiptId, status, errorText];

  ReceiptsHistoryState copyWith({
    List<ReceiptEntity>? receipts,
    String? receiptId,
    BlocStateStatus? status,
    String? errorText,
  }) {
    return ReceiptsHistoryState(
      receipts: receipts ?? this.receipts,
      receiptId: receiptId ?? this.receiptId,
      status: status ?? this.status,
      errorText: errorText ?? this.errorText,
    );
  }
}
