import 'package:dartz/dartz.dart';

import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/core/usecases/usecase.dart';
import 'package:check_bloc/features/crm/domain/entity/cash_register_crm_entity.dart';
import 'package:check_bloc/features/crm/domain/repository/cash_register_crm_repository.dart';

class GetCashRegistersCrmUseCase
    extends UseCase<List<CashRegisterCrmEntity>, NoParams> {
  final CashRegisterCrmRepository _cashRegisterCrmRepository;

  const GetCashRegistersCrmUseCase(this._cashRegisterCrmRepository);

  @override
  Future<Either<Failure, List<CashRegisterCrmEntity>>> call(
    NoParams params,
  ) async {
    return await _cashRegisterCrmRepository.registers();
  }
}
