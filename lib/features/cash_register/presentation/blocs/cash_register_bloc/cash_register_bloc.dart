import 'package:bloc/bloc.dart';
import 'package:check_bloc/core/usecases/usecase.dart';
import 'package:equatable/equatable.dart';

import 'package:check_bloc/config/constants.dart';
import 'package:check_bloc/features/cash_register/domain/entity/cash_register_entity.dart';
import 'package:check_bloc/features/cash_register/domain/usecases/cash_register/get_cash_register_info_use_case.dart';

part 'cash_register_event.dart';
part 'cash_register_state.dart';

class CashRegisterBloc extends Bloc<CashRegisterEvent, CashRegisterState> {
  final GetCashRegisterInfoUseCase _cashRegisterInfoUseCase;

  CashRegisterBloc(this._cashRegisterInfoUseCase)
      : super(const CashRegisterState.empty()) {
    on<CashRegisterLoadEvent>(_onLoad);
  }

  _onLoad(CashRegisterLoadEvent event, emit) async {
    emit(state.copyWith(status: BlocStateStatus.loading));

    final result = await _cashRegisterInfoUseCase(NoParams());

    result.fold(
      (error) => {
        emit(
          state.copyWith(
            status: BlocStateStatus.failure,
            errorText: error.message,
          ),
        )
      },
      (cashRegister) => {
        emit(
          state.copyWith(
            cashRegister: cashRegister,
            status: BlocStateStatus.success,
            errorText: '',
          ),
        )
      },
    );
  }
}
