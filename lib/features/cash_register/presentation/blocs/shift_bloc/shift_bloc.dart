import 'package:bloc/bloc.dart';
import 'package:check_bloc/config/constants.dart';
import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/features/cash_register/domain/entity/shift_entity.dart';
import 'package:check_bloc/features/cash_register/domain/repository/shift_repository.dart';
import 'package:equatable/equatable.dart';

part 'shift_event.dart';
part 'shift_state.dart';

class ShiftBloc extends Bloc<ShiftEvent, ShiftState> {
  final ShiftRepository _repository;
  ShiftBloc(this._repository) : super(const ShiftState.empty()) {
    on<ShiftInitialEvent>(_initial);
    on<ShiftCurrentEvent>(_current);
    on<ShiftOpenEvent>(_open);
    on<ShifCloseEvent>(_close);
    on<ShifCashInEvent>(_cashIn);
    on<ShifCashOutEvent>(_cashOut);
  }

  _initial(ShiftInitialEvent event, emit) async {
    final result = await _repository.get();

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
    final result = await _repository.get();

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

    final result = await _repository.open();

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
    final result = await _repository.close();
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

      final result = await _repository.cashIn(sum);

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

      final result = await _repository.cashOut(sum);

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
