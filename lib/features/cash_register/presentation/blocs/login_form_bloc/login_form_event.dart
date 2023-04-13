part of 'login_form_bloc.dart';

abstract class LoginFormEvent extends Equatable {
  const LoginFormEvent();

  @override
  List<Object> get props => [];
}

class LoginFormUserNameChangeEvent extends LoginFormEvent {
  final String? inputName;
  const LoginFormUserNameChangeEvent(this.inputName);
}

class LoginFormPasswordChangeEvent extends LoginFormEvent {
  final String? inputPassword;
  const LoginFormPasswordChangeEvent(this.inputPassword);
}

class LoginFormSubmitEvent extends LoginFormEvent {
  const LoginFormSubmitEvent();
}
