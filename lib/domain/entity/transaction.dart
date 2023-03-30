import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transaction.g.dart';

@JsonSerializable()
class Transaction extends Equatable {
  final String? id;
  final String? type;
  final int? serial;
  final String? status;
  @JsonKey(name: 'request_signed_at')
  final DateTime? requestSignedAt;
  @JsonKey(name: 'request_received_at')
  final DateTime? requestReceivedAt;
  @JsonKey(name: 'response_status')
  final String? responseStatus;
  @JsonKey(name: 'response_error_message')
  final String? responseErrorMessage;
  @JsonKey(name: 'response_id')
  final String? responseId;
  @JsonKey(name: 'offline_id')
  final String? offlineId;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  @JsonKey(name: 'original_datetime')
  final DateTime? originalDatetime;
  @JsonKey(name: 'previous_hash')
  final String? previousHash;

  const Transaction({
    this.id,
    this.type,
    this.serial,
    this.status,
    this.requestSignedAt,
    this.requestReceivedAt,
    this.responseStatus,
    this.responseErrorMessage,
    this.responseId,
    this.offlineId,
    this.createdAt,
    this.updatedAt,
    this.originalDatetime,
    this.previousHash,
  });

  @override
  List<Object?> get props {
    return [
      id,
      type,
      serial,
      status,
      requestSignedAt,
      requestReceivedAt,
      responseStatus,
      responseErrorMessage,
      responseId,
      offlineId,
      createdAt,
      updatedAt,
      originalDatetime,
      previousHash,
    ];
  }

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);
}
