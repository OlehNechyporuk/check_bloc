part of 'auth_crm_bloc.dart';

abstract class AuthCrmEvent extends Equatable {
  const AuthCrmEvent();

  @override
  List<Object> get props => [];
}

class AuthCrmCheckEvent extends AuthCrmEvent {}

class AuthCrmLoginEvent extends AuthCrmEvent {
  final String login;
  final String password;

  const AuthCrmLoginEvent({
    required this.login,
    required this.password,
  });
}

class AuthCrmLogoutkEvent extends AuthCrmEvent {}
