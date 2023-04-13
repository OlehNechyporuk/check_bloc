import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int id;
  final String email;
  final String? phone;
  final String? firstName;
  final String? middleName;
  final String? lastName;
  final String roles;
  final int status;
  final DateTime created;
  final String avatar;
  final bool verified;

  const UserEntity({
    required this.id,
    required this.email,
    this.phone,
    this.firstName,
    this.middleName,
    this.lastName,
    required this.roles,
    required this.status,
    required this.created,
    required this.avatar,
    required this.verified,
  });

  @override
  List<Object?> get props {
    return [
      id,
      email,
      phone,
      firstName,
      middleName,
      lastName,
      roles,
      status,
      created,
      avatar,
      verified,
    ];
  }
}
