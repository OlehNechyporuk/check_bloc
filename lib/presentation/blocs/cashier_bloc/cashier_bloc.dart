import 'package:bloc/bloc.dart';
import 'package:check_bloc/config/constants.dart';
import 'package:check_bloc/domain/entity/cashier_etity.dart';
import 'package:check_bloc/domain/repository/cashier_repository.dart';

import 'package:equatable/equatable.dart';

part 'cashier_event.dart';
part 'cashier_state.dart';

class CashierBloc extends Bloc<CashierEvent, CashierState> {
  final CashierRepository _repositry;

  CashierBloc(this._repositry) : super(const CashierState.empty()) {
    on<CashierLoadEvent>(_loadCashier);
  }

  _loadCashier(CashierLoadEvent event, emit) async {
    emit(state.copyWith(status: BlocStateStatus.loading));

    final result = await _repositry.info();

    result.fold((error) {
      emit(
        state.copyWith(
          errorText: error.message,
          status: BlocStateStatus.failure,
        ),
      );
    }, (cashier) {
      emit(
        state.copyWith(
          cashier: cashier,
          status: BlocStateStatus.success,
          errorText: null,
        ),
      );
    });
  }
}
