import 'package:dartz/dartz.dart';

import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/core/usecases/usecase.dart';
import 'package:check_bloc/features/cash_register/domain/entity/receipt_entity.dart';
import 'package:check_bloc/features/cash_register/domain/repository/shift_repository.dart';

class CashInShiftUseCase
    extends UseCase<ReceiptEntity, ShiftServiceCashInParams> {
  final ShiftRepository _repository;

  const CashInShiftUseCase(this._repository);

  @override
  Future<Either<Failure, ReceiptEntity>> call(
      ShiftServiceCashInParams params) async {
    return await _repository.cashIn(params.sum);
  }
}

class ShiftServiceCashInParams {
  final double sum;

  const ShiftServiceCashInParams(this.sum);
}
