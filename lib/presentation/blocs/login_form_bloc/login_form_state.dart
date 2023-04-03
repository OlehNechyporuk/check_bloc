part of 'login_form_bloc.dart';

class LoginFormState extends Equatable {
  final String userName;
  final String password;
  final bool isSubmit;
  final String errorText;
  final BlocStateStatus status;

  const LoginFormState(
    this.userName,
    this.password,
    this.isSubmit,
    this.errorText,
    this.status,
  );

  const LoginFormState.empty()
      : userName = '',
        password = '',
        isSubmit = false,
        errorText = '',
        status = BlocStateStatus.initial;

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
    BlocStateStatus? status,
  }) {
    return LoginFormState(
      userName ?? this.userName,
      password ?? this.password,
      isSubmit ?? this.isSubmit,
      errorText ?? this.errorText,
      status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        userName,
        password,
        canSubmit,
        isSubmit,
        errorText,
        status,
      ];
}
