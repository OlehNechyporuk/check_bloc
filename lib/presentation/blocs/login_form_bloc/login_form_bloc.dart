import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:check_bloc/config/main_navigation_name.dart';
import 'package:check_bloc/config/router.dart';
import 'package:check_bloc/data/checkbox/data_provider/auth_api_provider.dart';
import 'package:check_bloc/domain/repository/auth_repository.dart';
import 'package:check_bloc/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:equatable/equatable.dart';

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
    emit(state.copyWith(userName: event.inputName, errorText: ''));
  }

  void _onPasswordChange(LoginFormPasswordChangeEvent event, emit) {
    emit(state.copyWith(password: event.inputPassword, errorText: ''));
  }

  Future<void> _onSubmited(LoginFormSubmitEvent event, emit) async {
    if (!state.canSubmit || state.isSubmit) {
      return;
    }

    emit(state.copyWith(isSubmit: true));

    try {
      final bool result =
          await _repository.login(state.userName.trim(), state.password.trim());

      if (result) {
        router.goNamed(MainNavigationName.splashPage);
        _authBloc.add(AutCheckEvent());
      }
      emit(state.copyWith(isSubmit: false, userName: '', password: ''));
    } on AuthApiProviderIncorectLoginDataError catch (e) {
      emit(state.copyWith(isSubmit: false, errorText: e.msg));
    } on SocketException catch (_) {
      emit(state.copyWith(isSubmit: false, errorText: 'Немає Інтернету'));
    } catch (e) {
      emit(state.copyWith(isSubmit: false));
    }
  }
}
