part of 'user_crm_bloc.dart';

abstract class UserCrmEvent extends Equatable {
  const UserCrmEvent();

  @override
  List<Object> get props => [];
}

class UserCrmLoadedEvent extends UserCrmEvent {}
