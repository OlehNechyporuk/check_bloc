import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/core/usecases/usecase.dart';
import 'package:check_bloc/features/cash_register/domain/entity/receipt_entity.dart';
import 'package:check_bloc/features/cash_register/domain/repository/shift_repository.dart';
import 'package:dartz/dartz.dart';

class CloseShiftUseCase extends UseCase<ReceiptEntity, NoParams> {
  final ShiftRepository _repository;

  const CloseShiftUseCase(this._repository);

  @override
  Future<Either<Failure, ReceiptEntity>> call(NoParams params) async {
    return await _repository.close();
  }
}
