part of 'login_form_bloc.dart';

class LoginFormState extends Equatable {
  final String userName;
  final String password;
  final bool isSubmit;
  final String errorText;

  const LoginFormState(
      this.userName, this.password, this.isSubmit, this.errorText);

  bool get canSubmit {
    if (userName.isEmpty || password.isEmpty) {
      return false;
    }
    return true;
  }

  LoginFormState copyWith({
    String? userName,
    String? password,
    bool? isSubmit = false,
    String? errorText,
  }) {
    return LoginFormState(userName ?? this.userName, password ?? this.password,
        isSubmit ?? this.isSubmit, errorText ?? this.errorText);
  }

  @override
  List<Object> get props => [
        userName,
        password,
        canSubmit,
        isSubmit,
        errorText,
      ];
}
