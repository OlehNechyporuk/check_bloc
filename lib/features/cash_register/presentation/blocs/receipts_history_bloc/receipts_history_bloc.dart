import 'package:bloc/bloc.dart';
import 'package:check_bloc/core/usecases/usecase.dart';
import 'package:check_bloc/features/cash_register/domain/usecases/receipt_history/get_receipts_use_case.dart';
import 'package:equatable/equatable.dart';

import 'package:check_bloc/config/constants.dart';
import 'package:check_bloc/features/cash_register/domain/entity/receipt_entity.dart';
import 'package:flutter/material.dart';
part 'receipts_history_event.dart';
part 'receipts_history_state.dart';

class ReceiptsHistoryBloc
    extends Bloc<ReceiptsHistoryEvent, ReceiptsHistoryState> {
  final GetReceiptsUseCase _getReceiptsUseCase;

  ReceiptsHistoryBloc(this._getReceiptsUseCase)
      : super(ReceiptsHistoryState.empty()) {
    on<ReceiptsHistoryLoadedEvent>(_loaded);
  }

  _loaded(ReceiptsHistoryLoadedEvent event, emit) async {
    emit(state.copyWith(status: BlocStateStatus.loading));

    final result = await _getReceiptsUseCase(
      ReceiptHistoryParams(event.dateRange),
    );

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
          dateRange: event.dateRange,
        ),
      ),
    );
  }
}
