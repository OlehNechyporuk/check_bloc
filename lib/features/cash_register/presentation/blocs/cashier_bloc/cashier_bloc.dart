import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:check_bloc/config/constants.dart';
import 'package:check_bloc/core/usecases/usecase.dart';
import 'package:check_bloc/features/cash_register/domain/entity/cashier_etity.dart';
import 'package:check_bloc/features/cash_register/domain/usecases/cashier/get_cashier_use_case.dart';

part 'cashier_event.dart';
part 'cashier_state.dart';

class CashierBloc extends Bloc<CashierEvent, CashierState> {
  final GetCashierUseCase _cashierUseCase;

  CashierBloc(this._cashierUseCase) : super(const CashierState.empty()) {
    on<CashierLoadEvent>(_loadCashier);
  }

  _loadCashier(CashierLoadEvent event, emit) async {
    emit(state.copyWith(status: BlocStateStatus.loading));

    final result = await _cashierUseCase(NoParams());

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
