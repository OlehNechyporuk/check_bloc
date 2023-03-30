part of 'receipts_bloc.dart';

abstract class ReceiptsState extends Equatable {
  const ReceiptsState();

  @override
  List<Object?> get props => [];
}

class InititalState extends ReceiptsState {}

class LoadedState extends ReceiptsState {
  final List<Receipt>? receipts;
  final String? receipt;

  const LoadedState({required this.receipts, required this.receipt});

  @override
  List<Object?> get props => [receipts, receipt];

  LoadedState copyWith({
    List<Receipt>? receipts,
    String? receipt,
  }) {
    return LoadedState(
      receipts: receipts ?? this.receipts,
      receipt: receipt ?? this.receipt,
    );
  }
}
