import 'package:bloc/bloc.dart';
import 'package:check_bloc/features/crm/domain/entity/cash_register_crm_type.dart';
import 'package:equatable/equatable.dart';

import 'package:check_bloc/config/constants.dart';
import 'package:check_bloc/core/usecases/usecase.dart';
import 'package:check_bloc/features/crm/domain/entity/cash_register_crm_entity.dart';
import 'package:check_bloc/features/crm/domain/usecase/cash_register/get_cash_register_crm_type_use_case.dart';
import 'package:check_bloc/features/crm/domain/usecase/cash_register/get_cash_register_crm_use_case.dart';

part 'cash_register_crm_event.dart';
part 'cash_register_crm_state.dart';

class CashRegisterCrmBloc
    extends Bloc<CashRegisterCrmEvent, CashRegisterCrmState> {
  final GetCashRegistersCrmUseCase _cashRegistersCrmUseCase;
  final GetCashRegisterCrmTypeUseCase _cashRegisterCrmTypeUseCase;

  CashRegisterCrmBloc(
    this._cashRegistersCrmUseCase,
    this._cashRegisterCrmTypeUseCase,
  ) : super(const CashRegisterCrmState.empty()) {
    on<CashRegisterCrmLoadedListEvent>(_loadList);
    on<CashRegisterCrmLoadedTypesListEvent>(_loadTypes);
  }

  _loadList(CashRegisterCrmLoadedListEvent event, emit) async {
    emit(state.copyWith(status: BlocStateStatus.loading));

    final result = await _cashRegistersCrmUseCase(NoParams());

    result.fold(
      (error) => emit(
        state.copyWith(
          status: BlocStateStatus.failure,
          errorText: error.message,
        ),
      ),
      (registers) => emit(
        state.copyWith(
          status: BlocStateStatus.success,
          registers: registers,
        ),
      ),
    );
  }

  _loadTypes(CashRegisterCrmLoadedTypesListEvent event, emit) async {
    emit(state.copyWith(status: BlocStateStatus.loading));

    final result = await _cashRegisterCrmTypeUseCase(NoParams());
    result.fold(
      (error) => emit(
        state.copyWith(
          status: BlocStateStatus.failure,
          errorText: error.message,
        ),
      ),
      (types) {
        emit(
          state.copyWith(types: types, status: BlocStateStatus.success),
        );
      },
    );
  }
}
