import 'package:json_annotation/json_annotation.dart';

import 'package:check_bloc/features/cash_register/domain/entity/transaction_entity.dart';

part 'transaction_model.g.dart';

@JsonSerializable()
class TransactionModel extends TransactionEntity {
  const TransactionModel({
    required super.id,
    required super.type,
    required super.serial,
    required super.status,
    required super.requestSignedAt,
    required super.requestReceivedAt,
    required super.responseStatus,
    required super.responseErrorMessage,
    required super.responseId,
    required super.offlineId,
    required super.createdAt,
    required super.updatedAt,
    required super.originalDatetime,
    required super.previousHash,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionModelToJson(this);
}
