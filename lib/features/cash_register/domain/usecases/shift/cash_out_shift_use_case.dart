import 'package:dartz/dartz.dart';

import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/core/usecases/usecase.dart';
import 'package:check_bloc/features/cash_register/domain/entity/receipt_entity.dart';
import 'package:check_bloc/features/cash_register/domain/repository/shift_repository.dart';

class CashOutShiftUseCase
    extends UseCase<ReceiptEntity, ShiftServiceCashOutParams> {
  final ShiftRepository _repository;

  const CashOutShiftUseCase(this._repository);
  @override
  Future<Either<Failure, ReceiptEntity>> call(
      ShiftServiceCashOutParams params) async {
    return await _repository.cashOut(params.sum);
  }
}

class ShiftServiceCashOutParams {
  final double sum;

  const ShiftServiceCashOutParams(this.sum);
}
