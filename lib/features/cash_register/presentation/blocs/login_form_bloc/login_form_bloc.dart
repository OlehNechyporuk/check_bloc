import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:check_bloc/features/cash_register/domain/usecases/auth/login_cash_register_use_case.dart';
import 'package:equatable/equatable.dart';

import 'package:check_bloc/config/constants.dart';

part 'login_form_event.dart';
part 'login_form_state.dart';

class LoginFormBloc extends Bloc<LoginFormEvent, LoginFormState> {
  final LoginCashRegisterUseCase _registerUseCase;

  LoginFormBloc(this._registerUseCase) : super(const LoginFormState.empty()) {
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

    final result = await _registerUseCase(
      AuthCashRegisterParams(
        state.userName.trim(),
        state.password.trim(),
      ),
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
