import 'package:bloc/bloc.dart';
import 'package:check_bloc/config/constants.dart';
import 'package:check_bloc/features/crm/domain/entity/cash_register_crm_entity.dart';
import 'package:check_bloc/features/crm/domain/usecase/cash_register/add_cash_register_crm_use_case.dart';
import 'package:equatable/equatable.dart';

part 'add_cash_register_crm_event.dart';
part 'add_cash_register_crm_state.dart';

class AddCashRegisterCrmBloc
    extends Bloc<AddCashRegisterCrmEvent, AddCashRegisterCrmState> {
  final AddCashRegisterCrmUseCase _addCashRegisterCrmUseCase;
  AddCashRegisterCrmBloc(
    this._addCashRegisterCrmUseCase,
  ) : super(const AddCashRegisterCrmState.empty()) {
    on<AddCashRegisterAddCrmEvent>(_addRegister);
  }

  _addRegister(AddCashRegisterAddCrmEvent event, emit) async {
    emit(state.copyWith(status: BlocStateStatus.loading));

    final result = await _addCashRegisterCrmUseCase(
      AddCashRegisterParams(title: event.title, typeId: event.typeId),
    );

    result.fold(
      (error) => emit(
        state.copyWith(
          status: BlocStateStatus.failure,
          errorText: error.message,
        ),
      ),
      (cashRegister) {
        emit(
          state.copyWith(
            status: BlocStateStatus.success,
            cashRegister: cashRegister,
          ),
        );
      },
    );
  }
}
