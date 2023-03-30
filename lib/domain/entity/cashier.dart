import 'package:equatable/equatable.dart';

import 'package:check_bloc/domain/entity/organization.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cashier.g.dart';

@JsonSerializable()
class Cashier extends Equatable {
  final String? id;
  @JsonKey(name: 'full_name')
  final String? fullName;
  final String? nin;
  @JsonKey(name: 'key_id')
  final String? keyId;
  @JsonKey(name: 'signature_type')
  final String? signatureType;
  final Map<String, bool>? permissions;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  @JsonKey(name: 'certificate_end')
  final DateTime? certificateEnd;
  final String? blocked;
  final Organization? organization;

  const Cashier({
    this.id,
    this.fullName,
    this.nin,
    this.keyId,
    this.signatureType,
    this.permissions,
    this.createdAt,
    this.updatedAt,
    this.certificateEnd,
    this.blocked,
    this.organization,
  });

  @override
  List<Object?> get props => [
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

  Cashier copyWith({
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
    Organization? organization,
  }) {
    return Cashier(
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

  factory Cashier.fromJson(Map<String, dynamic> json) =>
      _$CashierFromJson(json);
}
