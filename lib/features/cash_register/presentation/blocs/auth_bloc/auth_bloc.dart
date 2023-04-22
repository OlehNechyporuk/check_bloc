import 'package:bloc/bloc.dart';
import 'package:check_bloc/config/constants.dart';
import 'package:check_bloc/features/cash_register/domain/repository/auth_repository.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repository;

  AuthBloc(this._repository) : super(const AuthState.empty()) {
    on<AutCheckEvent>((AutCheckEvent event, emit) async {
      bool result = await _repository.checkAuth(event.cashRegisterId);
      if (result) {
        emit(
          state.copyWith(
            status: BlocStateStatus.success,
            cashRegisterId: event.cashRegisterId,
          ),
        );
      } else {
        emit(
          state.copyWith(status: BlocStateStatus.failure),
        );
      }
    });
    on<AuthLogoutEvent>((AuthLogoutEvent event, emit) async {
      await _repository.logout(event.cashRegisterId);
      emit(
        state.copyWith(
          status: BlocStateStatus.initial,
          cashRegisterId: null,
        ),
      );
    });
  }
}
