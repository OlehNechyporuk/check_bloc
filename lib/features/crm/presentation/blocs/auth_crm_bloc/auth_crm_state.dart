part of 'auth_crm_bloc.dart';

class AuthCrmState extends Equatable {
  final String? errorText;
  final BlocStateStatus status;

  const AuthCrmState({
    required this.errorText,
    required this.status,
  });

  const AuthCrmState.empty()
      : errorText = null,
        status = BlocStateStatus.initial;

  @override
  List<Object?> get props => [errorText, status];
}
