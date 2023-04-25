part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final String? cashRegisterId;
  final BlocStateStatus status;
  final String? errorText;

  const AuthState({
    required this.cashRegisterId,
    required this.status,
    required this.errorText,
  });

  const AuthState.empty()
      : cashRegisterId = null,
        status = BlocStateStatus.initial,
        errorText = null;

  @override
  List<Object?> get props => [cashRegisterId, status, errorText];

  AuthState copyWith({
    String? cashRegisterId,
    BlocStateStatus? status,
    String? errorText,
  }) {
    return AuthState(
      cashRegisterId: cashRegisterId ?? this.cashRegisterId,
      status: status ?? this.status,
      errorText: errorText,
    );
  }
}
