import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:check_bloc/config/constants.dart';
import 'package:check_bloc/config/main_navigation_name.dart';
import 'package:check_bloc/config/router.dart';
import 'package:check_bloc/features/cash_register/domain/repository/auth_repository.dart';
import 'package:check_bloc/features/cash_register/presentation/blocs/auth_bloc/auth_bloc.dart';

part 'login_form_event.dart';
part 'login_form_state.dart';

class LoginFormBloc extends Bloc<LoginFormEvent, LoginFormState> {
  final AuthBloc _authBloc;
  final AuthRepository _repository;

  LoginFormBloc(this._authBloc, this._repository)
      : super(const LoginFormState.empty()) {
    on<LoginFormUserNameChangeEvent>(_onUserNameChange);
    on<LoginFormPasswordChangeEvent>(_onPasswordChange);
    on<LoginFormSubmitEvent>(_onSubmited);
  }

  void _onUserNameChange(LoginFormUserNameChangeEvent event, emit) {
    emit(state.copyWith(userName: event.inputName));
  }

  void _onPasswordChange(LoginFormPasswordChangeEvent event, emit) {
    emit(state.copyWith(password: event.inputPassword));
  }

  Future<void> _onSubmited(LoginFormSubmitEvent event, emit) async {
    if (!state.canSubmit || state.isSubmit) {
      return;
    }

    emit(state.copyWith(isSubmit: true, status: BlocStateStatus.loading));

    final result = await _repository.login(
      state.userName.trim(),
      state.password.trim(),
      event.cashRegisterId,
    );

    result.fold(
      (error) {
        emit(
          state.copyWith(
            isSubmit: false,
            userName: '',
            password: '',
            status: BlocStateStatus.failure,
            errorText: error.message,
          ),
        );
      },
      (success) => {
        router.goNamed(CashRegisterNavigationName.splashPageCashRegister),
        _authBloc.add(AutCheckEvent(event.cashRegisterId)),
        emit(
          state.copyWith(
            isSubmit: false,
            userName: '',
            password: '',
            status: BlocStateStatus.success,
          ),
        )
      },
    );
  }
}
