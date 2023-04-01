import 'package:bloc/bloc.dart';
import 'package:check_bloc/domain/entity/shift.dart';
import 'package:check_bloc/domain/repository/shift_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'shift_event.dart';
part 'shift_state.dart';

class ShiftBloc extends Bloc<ShiftEvent, ShiftState> {
  final ShiftRepository _repository;
  ShiftBloc(this._repository)
      : super(
          ShiftState(
            null,
            TextEditingController(),
            TextEditingController(),
          ),
        ) {
    on<ShiftInitialEvent>(_initial);
    on<ShiftOpenEvent>(_open);
    on<ShifCloseEvent>(_close);
    on<ShifCashInEvent>(_cashIn);
    on<ShifCashOutEvent>(_cashOut);
  }

  _initial(ShiftInitialEvent event, emit) async {
    final Shift? shift = await _repository.get();
    emit(state.copyWith(shift: shift));
  }

  _open(ShiftOpenEvent event, emit) async {
    final Shift? shift = await _repository.open();
    emit(state.copyWith(shift: shift));
  }

  _close(ShifCloseEvent event, emit) async {
    await _repository.close();
    emit(state.copyWith(shift: null));
  }

  _cashIn(ShifCashInEvent event, emit) async {
    var str = state.cashInController?.text;
    double sum = double.parse(str ?? '0');
    if (sum <= 0) return;

    await _repository.cashIn(sum);
    state.cashInController?.clear();

    add(ShiftInitialEvent());
  }

  _cashOut(ShifCashOutEvent event, emit) async {
    String? str = state.cashOutController?.text;
    if (str == null) {
      return;
    }

    var sum = double.tryParse(str);
    if (sum == null) return;
    if (sum <= 0) return;

    await _repository.cashOut(sum);
    state.cashOutController?.clear();

    add(ShiftInitialEvent());
  }

  @override
  Future<void> close() {
    state.cashInController?.dispose();
    state.cashOutController?.dispose();
    return super.close();
  }
}
