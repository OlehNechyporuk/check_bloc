import 'package:bloc/bloc.dart';
import 'package:check_bloc/features/cash_register/domain/entity/shift_entity.dart';
import 'package:equatable/equatable.dart';

import 'package:check_bloc/config/constants.dart';
import 'package:check_bloc/features/cash_register/domain/usecases/reports/get_shifts_use_case.dart';
import 'package:flutter/material.dart';

part 'shifts_history_event.dart';
part 'shifts_history_state.dart';

class ShiftsHistoryBloc extends Bloc<ShiftsHistoryEvent, ShiftsHistoryState> {
  final GetShiftsUseCase _getShiftsUseCase;

  ShiftsHistoryBloc(this._getShiftsUseCase)
      : super(const ShiftsHistoryState.empty()) {
    on<ShiftsHistoryLoadedEvent>(_loaded);
  }
  _loaded(ShiftsHistoryLoadedEvent event, emit) async {
    emit(state.copyWith(status: BlocStateStatus.loading));

    final result = await _getShiftsUseCase(
      ShiftsPaginationsParams(
        dateTimeRange:
            DateTimeRange(start: DateTime.now(), end: DateTime.now()),
        limit: 25,
        offset: 0,
      ),
    );

    result.fold((error) {
      emit(
        state.copyWith(
          errorText: error.message,
          status: BlocStateStatus.failure,
        ),
      );
    }, (shifts) {
      emit(state.copyWith(shifts: shifts, status: BlocStateStatus.success));
    });
  }
}
