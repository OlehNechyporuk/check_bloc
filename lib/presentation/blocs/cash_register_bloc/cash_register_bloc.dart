import 'package:bloc/bloc.dart';
import 'package:check_bloc/domain/entity/cash_register.dart';
import 'package:check_bloc/domain/repository/cash_register_repository.dart';
import 'package:equatable/equatable.dart';

part 'cash_register_event.dart';
part 'cash_register_state.dart';

class CashRegisterBloc extends Bloc<CashRegisterEvent, CashRegisterState> {
  final CashRegisterRepository _registerRepository;

  CashRegisterBloc(this._registerRepository)
      : super(const CashRegisterState(null)) {
    on<CashRegisterLoadEvent>(_onLoad);
  }

  _onLoad(CashRegisterLoadEvent event, emit) async {
    final CashRegister? cashRegister =
        await _registerRepository.getCashRegisterInfo();
    emit(state.copyWith(cashRegister: cashRegister));
  }
}
