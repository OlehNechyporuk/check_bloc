part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AutCheckEvent extends AuthEvent {
  final String cashRegisterId;
  const AutCheckEvent(this.cashRegisterId);
}

class AuthLogoutEvent extends AuthEvent {
  final String cashRegisterId;
  const AuthLogoutEvent(this.cashRegisterId);
}
