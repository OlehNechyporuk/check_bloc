import 'package:bloc/bloc.dart';
import 'package:check_bloc/domain/entity/cashier.dart';
import 'package:check_bloc/domain/repository/cashier_repository.dart';
import 'package:equatable/equatable.dart';

part 'cashier_event.dart';
part 'cashier_state.dart';

class CashierBloc extends Bloc<CashierEvent, CashierState> {
  final CashierRepositry _repositry;

  CashierBloc(this._repositry) : super(const CashierState(null)) {
    on<CashierLoadEvent>(_loadCashier);
  }

  _loadCashier(CashierLoadEvent event, emit) async {
    final cashier = await _repositry.loadInfo();

    emit(state.copyWith(cashier: cashier));
  }
}
