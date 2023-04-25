import 'package:bloc/bloc.dart';
import 'package:check_bloc/config/constants.dart';
import 'package:check_bloc/core/usecases/usecase.dart';
import 'package:check_bloc/features/cash_register/domain/usecases/auth/change_current_cash_register_use_case.dart';
import 'package:check_bloc/features/cash_register/domain/usecases/auth/check_auth_use_case.dart';
import 'package:check_bloc/features/cash_register/domain/usecases/auth/logout_cash_register_use_case.dart';

import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final CheckAuthCashRegisterUseCase _authCashRegisterUseCase;
  final ChangeCurrentCashRegisterUseCase _changeCurrentCashRegisterUseCase;
  final LogoutCashRegisteruseCase _logoutCashRegisteruseCase;
  AuthBloc(
    this._authCashRegisterUseCase,
    this._changeCurrentCashRegisterUseCase,
    this._logoutCashRegisteruseCase,
  ) : super(const AuthState.empty()) {
    on<AutCheckEvent>(_checkAuht);
    on<AuthChangeCurrentCashRegisterEvent>(_changeCurrentCashRegister);
    on<AuthLogoutEvent>(_logout);
  }

  _checkAuht(AutCheckEvent event, emit) async {
    emit(const AuthState.empty());

    final result = await _authCashRegisterUseCase(NoParams());
    result.fold((error) {
      emit(
        state.copyWith(
          status: BlocStateStatus.failure,
          errorText: error.message,
        ),
      );
    }, (success) {
      if (success) {
        emit(
          state.copyWith(
            status: BlocStateStatus.success,
          ),
        );
      }
    });
  }

  _changeCurrentCashRegister(
    AuthChangeCurrentCashRegisterEvent event,
    emit,
  ) async {
    await _changeCurrentCashRegisterUseCase(event.cashRegisterId);
  }

  _logout(AuthLogoutEvent event, emit) async {
    await _logoutCashRegisteruseCase.call(NoParams());
  }
}
