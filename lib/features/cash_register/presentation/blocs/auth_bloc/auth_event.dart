part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AutCheckEvent extends AuthEvent {}

class AuthLogoutEvent extends AuthEvent {
  const AuthLogoutEvent();
}

class AuthChangeCurrentCashRegisterEvent extends AuthEvent {
  final String cashRegisterId;
  const AuthChangeCurrentCashRegisterEvent(this.cashRegisterId);
}
