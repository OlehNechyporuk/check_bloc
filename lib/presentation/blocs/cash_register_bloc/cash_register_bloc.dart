import 'package:bloc/bloc.dart';
import 'package:check_bloc/config/constants.dart';
import 'package:check_bloc/domain/entity/cash_register_entity.dart';
import 'package:check_bloc/domain/repository/cash_register_repository.dart';
import 'package:equatable/equatable.dart';

part 'cash_register_event.dart';
part 'cash_register_state.dart';

class CashRegisterBloc extends Bloc<CashRegisterEvent, CashRegisterState> {
  final CashRegisterRepository _registerRepository;

  CashRegisterBloc(this._registerRepository)
      : super(const CashRegisterState.empty()) {
    on<CashRegisterLoadEvent>(_onLoad);
  }

  _onLoad(CashRegisterLoadEvent event, emit) async {
    emit(state.copyWith(status: BlocStateStatus.loading));

    final result = await _registerRepository.info();

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
