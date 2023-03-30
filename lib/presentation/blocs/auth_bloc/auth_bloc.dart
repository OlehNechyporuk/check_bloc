import 'package:bloc/bloc.dart';
import 'package:check_bloc/domain/repository/auth_repository.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repository;

  AuthBloc(this._repository) : super(AuthInitial()) {
    on<AutCheckEvent>((AutCheckEvent event, emit) async {
      bool result = await _repository.checkAuth();
      if (result) {
        emit(AuthSuccess());
      } else {
        emit(AuthFailState());
      }
    });
    on<AuthLogoutEvent>((AuthLogoutEvent event, emit) async {
      await _repository.logout();
      emit(AuthInitial());
    });
  }
}
