// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_crm_bloc.dart';

class UserCrmState extends Equatable {
  final BlocStateStatus status;
  final UserEntity? user;
  final String? errorText;

  const UserCrmState({
    required this.status,
    required this.user,
    required this.errorText,
  });

  const UserCrmState.empty()
      : status = BlocStateStatus.initial,
        user = null,
        errorText = null;

  @override
  List<Object?> get props => [status, user, errorText];

  UserCrmState copyWith({
    BlocStateStatus? status,
    UserEntity? user,
    String? errorText,
  }) {
    return UserCrmState(
      status: status ?? this.status,
      user: user,
      errorText: errorText,
    );
  }
}
