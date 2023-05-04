import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/core/usecases/usecase.dart';
import 'package:check_bloc/features/cash_register/domain/entity/receipt_entity.dart';
import 'package:check_bloc/features/cash_register/domain/repository/receipt_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class GetReceiptsUseCase
    extends UseCase<List<ReceiptEntity>, ReceiptHistoryParams> {
  final ReceiptRepository _receiptRepository;

  const GetReceiptsUseCase(this._receiptRepository);

  @override
  Future<Either<Failure, List<ReceiptEntity>>> call(
    ReceiptHistoryParams params,
  ) async {
    return await _receiptRepository.receipts(
      dateTimeRange: params.dateTimeRange,
    );
  }
}

class ReceiptHistoryParams {
  final DateTimeRange? dateTimeRange;
  const ReceiptHistoryParams(this.dateTimeRange);
}
