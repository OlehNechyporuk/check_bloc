part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final String? cashRegisterId;
  final BlocStateStatus status;

  const AuthState({
    required this.cashRegisterId,
    required this.status,
  });

  const AuthState.empty()
      : cashRegisterId = null,
        status = BlocStateStatus.initial;

  @override
  List<Object?> get props => [cashRegisterId, status];

  AuthState copyWith({
    String? cashRegisterId,
    BlocStateStatus? status,
  }) {
    return AuthState(
      cashRegisterId: cashRegisterId,
      status: status ?? this.status,
    );
  }
}
