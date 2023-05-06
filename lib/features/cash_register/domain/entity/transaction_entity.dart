import 'package:equatable/equatable.dart';

class TransactionEntity extends Equatable {
  final String id;
  final String type;
  final int serial;
  final String status;
  final DateTime? requestSignedAt;
  final DateTime? requestReceivedAt;
  final String responseStatus;
  final String? responseErrorMessage;
  final String responseId;
  final String? offlineId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime originalDatetime;
  final String previousHash;

  const TransactionEntity({
    required this.id,
    required this.type,
    required this.serial,
    required this.status,
    required this.requestSignedAt,
    required this.requestReceivedAt,
    required this.responseStatus,
    required this.responseErrorMessage,
    required this.responseId,
    required this.offlineId,
    required this.createdAt,
    required this.updatedAt,
    required this.originalDatetime,
    required this.previousHash,
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
}
