import 'package:dartz/dartz.dart';

import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/core/usecases/usecase.dart';
import 'package:check_bloc/features/crm/domain/entity/cash_register_crm_type.dart';
import 'package:check_bloc/features/crm/domain/repository/cash_register_crm_repository.dart';

class GetCashRegisterCrmTypeUseCase
    extends UseCase<List<CashRegisterTypeCrmEntity>, NoParams> {
  final CashRegisterCrmRepository _cashRegisterCrmRepository;

  const GetCashRegisterCrmTypeUseCase(this._cashRegisterCrmRepository);
  @override
  Future<Either<Failure, List<CashRegisterTypeCrmEntity>>> call(
    NoParams params,
  ) async {
    return await _cashRegisterCrmRepository.types();
  }
}
