import 'package:bloc/bloc.dart';
import 'package:check_bloc/features/cash_register/domain/usecases/shift/cash_in_shift_use_case.dart';
import 'package:check_bloc/features/cash_register/domain/usecases/shift/cash_out_shift_use_case.dart';
import 'package:check_bloc/features/cash_register/domain/usecases/shift/close_shift_use_case.dart';
import 'package:equatable/equatable.dart';

import 'package:check_bloc/config/constants.dart';
import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/core/usecases/usecase.dart';
import 'package:check_bloc/features/cash_register/domain/entity/shift_entity.dart';
import 'package:check_bloc/features/cash_register/domain/usecases/shift/get_shift_use_case.dart';
import 'package:check_bloc/features/cash_register/domain/usecases/shift/open_shift_use_case.dart';

part 'shift_event.dart';
part 'shift_state.dart';

class ShiftBloc extends Bloc<ShiftEvent, ShiftState> {
  final OpenShiftUseCase _openShiftUseCase;
  final GetShiftUseCase _getShiftUseCase;
  final CloseShiftUseCase _closeShiftUseCase;
  final CashInShiftUseCase _cashInShiftUseCase;
  final CashOutShiftUseCase _cashOutShiftUseCase;

  ShiftBloc(
    this._openShiftUseCase,
    this._getShiftUseCase,
    this._closeShiftUseCase,
    this._cashInShiftUseCase,
    this._cashOutShiftUseCase,
  ) : super(const ShiftState.empty()) {
    on<ShiftInitialEvent>(_initial);
    on<ShiftCurrentEvent>(_current);
    on<ShiftOpenEvent>(_open);
    on<ShifCloseEvent>(_close);
    on<ShifCashInEvent>(_cashIn);
    on<ShifCashOutEvent>(_cashOut);
  }

  _initial(ShiftInitialEvent event, emit) async {
    final result = await _getShiftUseCase(NoParams());

    result.fold(
      (error) => emit(
        state.copyWith(
          errorText: error.message,
          status: BlocStateStatus.failure,
        ),
      ),
      (shift) => emit(
        state.copyWith(
          shift: shift,
          status: BlocStateStatus.success,
        ),
      ),
    );
  }

  _current(ShiftCurrentEvent event, emit) async {
    final result = await _getShiftUseCase(NoParams());

    result.fold(
      (error) => emit(
        state.copyWith(
          errorText: error.message,
          status: BlocStateStatus.failure,
        ),
      ),
      (shift) => emit(
        state.copyWith(
          shift: shift,
          status: BlocStateStatus.success,
        ),
      ),
    );
  }

  _open(ShiftOpenEvent event, emit) async {
    emit(state.copyWith(status: BlocStateStatus.loading));

    final result = await _openShiftUseCase(NoParams());

    result.fold(
      (error) => emit(
        state.copyWith(
          status: BlocStateStatus.failure,
          errorText: error.message,
        ),
      ),
      (shift) => emit(
        state.copyWith(
          shift: shift,
          status: BlocStateStatus.success,
        ),
      ),
    );
  }

  _close(ShifCloseEvent event, emit) async {
    state.copyWith(shift: null, status: BlocStateStatus.loading);

    final result = await _closeShiftUseCase(NoParams());

    result.fold(
      (error) => emit(
        state.copyWith(
          errorText: error.message,
          status: BlocStateStatus.failure,
        ),
      ),
      (r) => emit(state.copyWith(status: BlocStateStatus.success)),
    );
  }

  _cashIn(ShifCashInEvent event, emit) async {
    final double? sum = event.sum;

    if (sum == null || sum <= 0) {
      emit(
        state.copyWith(
          shift: state.shift,
          status: BlocStateStatus.failure,
          errorText: FailureMessages.emptySum,
        ),
      );
    } else {
      state.copyWith(shift: null, status: BlocStateStatus.loading);

      final result = await _cashInShiftUseCase(ShiftServiceCashInParams(sum));

      result.fold(
        (error) => state.copyWith(
          errorText: error.message,
          status: BlocStateStatus.failure,
        ),
        (r) => add(ShiftCurrentEvent()),
      );
    }
  }

  _cashOut(ShifCashOutEvent event, emit) async {
    final double? sum = event.sum;

    if (sum == null || sum <= 0) {
      emit(
        state.copyWith(
          status: BlocStateStatus.failure,
          shift: state.shift,
          errorText: FailureMessages.emptySum,
        ),
      );
    } else {
      state.copyWith(shift: null, status: BlocStateStatus.loading);

      final result = await _cashOutShiftUseCase(ShiftServiceCashOutParams(sum));

      result.fold(
        (error) => emit(
          state.copyWith(
            shift: state.shift,
            errorText: error.message,
            status: BlocStateStatus.failure,
          ),
        ),
        (r) => add(ShiftCurrentEvent()),
      );
    }
  }
}
