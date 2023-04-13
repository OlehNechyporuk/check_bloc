import 'package:equatable/equatable.dart';
import 'package:check_bloc/features/cash_register/domain/entity/organization_entity.dart';

class CashierEntity extends Equatable {
  final String id;
  final String fullName;
  final String nin;
  final String keyId;
  final String signatureType;
  final Map<String, bool> permissions;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? certificateEnd;
  final String? blocked;
  final OrganizationEntity organization;

  const CashierEntity({
    required this.id,
    required this.fullName,
    required this.nin,
    required this.keyId,
    required this.signatureType,
    required this.permissions,
    required this.createdAt,
    required this.updatedAt,
    required this.certificateEnd,
    required this.blocked,
    required this.organization,
  });

  @override
  List<Object?> get props {
    return [
      id,
      fullName,
      nin,
      keyId,
      signatureType,
      permissions,
      createdAt,
      updatedAt,
      certificateEnd,
      blocked,
      organization,
    ];
  }

  CashierEntity copyWith({
    String? id,
    String? fullName,
    String? nin,
    String? keyId,
    String? signatureType,
    Map<String, bool>? permissions,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? certificateEnd,
    String? blocked,
    OrganizationEntity? organization,
  }) {
    return CashierEntity(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      nin: nin ?? this.nin,
      keyId: keyId ?? this.keyId,
      signatureType: signatureType ?? this.signatureType,
      permissions: permissions ?? this.permissions,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      certificateEnd: certificateEnd ?? this.certificateEnd,
      blocked: blocked ?? this.blocked,
      organization: organization ?? this.organization,
    );
  }
}
