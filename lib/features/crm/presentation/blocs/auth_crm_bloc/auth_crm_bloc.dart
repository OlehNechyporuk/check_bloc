import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:check_bloc/config/constants.dart';
import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/core/usecases/usecase.dart';
import 'package:check_bloc/features/crm/domain/usecase/auth/check_user_auth_status_use_case.dart';
import 'package:check_bloc/features/crm/domain/usecase/auth/login_auth_crm_use_case.dart';
import 'package:check_bloc/features/crm/domain/usecase/auth/logout_auth_crm_use_case.dart';

part 'auth_crm_event.dart';
part 'auth_crm_state.dart';

class AuthCrmBloc extends Bloc<AuthCrmEvent, AuthCrmState> {
  final CheckUserAuthStatusUseCase _authChekUsecase;
  final LoginAuthCrmUseCase _loginUseCase;
  final LogoutAuthCrmUseCase _logoutUseCase;

  AuthCrmBloc(
    this._authChekUsecase,
    this._logoutUseCase,
    this._loginUseCase,
  ) : super(const AuthCrmState.empty()) {
    on<AuthCrmCheckEvent>(_check);
    on<AuthCrmLoginEvent>(_login);
    on<AuthCrmLogoutkEvent>(_logout);
  }

  _check(AuthCrmCheckEvent event, emit) async {
    final result = await _authChekUsecase(NoParams());

    result.fold(
      (error) => emit(
        const AuthCrmState(errorText: null, status: BlocStateStatus.failure),
      ),
      (success) => emit(
        const AuthCrmState(errorText: null, status: BlocStateStatus.success),
      ),
    );
  }

  _login(AuthCrmLoginEvent event, emit) async {
    emit(const AuthCrmState(errorText: null, status: BlocStateStatus.loading));

    if (event.login.isEmpty || event.password.isEmpty) {
      emit(
        const AuthCrmState(
          errorText: FailureMessages.emptyLoginOrPassword,
          status: BlocStateStatus.failure,
        ),
      );
    }

    final result = await _loginUseCase(
      AuthParams(login: event.login, password: event.password),
    );

    result.fold(
      (error) => emit(
        AuthCrmState(
          errorText: error.message,
          status: BlocStateStatus.failure,
        ),
      ),
      (success) => emit(
        const AuthCrmState(
          errorText: null,
          status: BlocStateStatus.success,
        ),
      ),
    );
  }

  _logout(AuthCrmLogoutkEvent event, emit) async {
    await _logoutUseCase(NoParams());
  }
}
