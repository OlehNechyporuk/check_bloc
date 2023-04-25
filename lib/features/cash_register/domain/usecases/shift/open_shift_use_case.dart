import 'package:dartz/dartz.dart';

import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/core/usecases/usecase.dart';
import 'package:check_bloc/features/cash_register/domain/entity/shift_entity.dart';
import 'package:check_bloc/features/cash_register/domain/repository/shift_repository.dart';

class OpenShiftUseCase extends UseCase<ShiftEntity, NoParams> {
  final ShiftRepository _repository;

  const OpenShiftUseCase(this._repository);

  @override
  Future<Either<Failure, ShiftEntity>> call(NoParams params) async {
    return await _repository.open();
  }
}
