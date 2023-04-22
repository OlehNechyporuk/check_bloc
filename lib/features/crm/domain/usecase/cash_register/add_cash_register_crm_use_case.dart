import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/core/usecases/usecase.dart';
import 'package:check_bloc/features/crm/domain/entity/cash_register_crm_entity.dart';
import 'package:check_bloc/features/crm/domain/repository/cash_register_crm_repository.dart';

class AddCashRegisterCrmUseCase
    extends UseCase<CashRegisterCrmEntity, AddCashRegisterParams> {
  final CashRegisterCrmRepository _cashRegisterCrmRepository;
  const AddCashRegisterCrmUseCase(this._cashRegisterCrmRepository);
  @override
  Future<Either<Failure, CashRegisterCrmEntity>> call(
    AddCashRegisterParams params,
  ) async {
    return await _cashRegisterCrmRepository.add(params.title, params.typeId);
  }
}

class AddCashRegisterParams extends Equatable {
  final String title;
  final int typeId;

  const AddCashRegisterParams({required this.title, required this.typeId});

  @override
  List<Object> get props => [title, typeId];
}
