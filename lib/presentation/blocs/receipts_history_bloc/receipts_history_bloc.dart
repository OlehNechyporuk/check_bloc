import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:check_bloc/config/constants.dart';
import 'package:check_bloc/domain/entity/receipt_entity.dart';
import 'package:check_bloc/domain/repository/receipt_repository.dart';

part 'receipts_history_event.dart';
part 'receipts_history_state.dart';

class ReceiptsHistoryBloc
    extends Bloc<ReceiptsHistoryEvent, ReceiptsHistoryState> {
  final ReceiptRepository _receiptRepository;
  ReceiptsHistoryBloc(this._receiptRepository)
      : super(const ReceiptsHistoryState.empty()) {
    on<ReceiptsHistoryLoadedEvent>(_loaded);
  }

  _loaded(ReceiptsHistoryLoadedEvent event, emit) async {
    emit(state.copyWith(status: BlocStateStatus.loading));

    final result = await _receiptRepository.receipts();

    result.fold(
      (error) => emit(
        state.copyWith(
          errorText: error.message,
          status: BlocStateStatus.failure,
        ),
      ),
      (reciepts) => emit(
        state.copyWith(
          receipts: reciepts,
          status: BlocStateStatus.success,
        ),
      ),
    );
  }
}
