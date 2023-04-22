import 'package:dartz/dartz.dart';

import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/features/cash_register/data/checkbox/data_provider/session_data_provider.dart';
import 'package:check_bloc/features/crm/data/data_provider/cash_register_crm_data_provider.dart';
import 'package:check_bloc/features/crm/domain/entity/cash_register_crm_entity.dart';
import 'package:check_bloc/features/crm/domain/entity/cash_register_crm_type.dart';
import 'package:check_bloc/features/crm/domain/repository/cash_register_crm_repository.dart';

class CashRegisterCrmRepositoryImpl extends CashRegisterCrmRepository {
  final CashRegisterCrmDataProvider _cashRegisterCrmDataProvider;
  final SessionDataProvider _sessionDataProvider;

  const CashRegisterCrmRepositoryImpl(
    this._cashRegisterCrmDataProvider,
    this._sessionDataProvider,
  );

  @override
  Future<Either<Failure, CashRegisterCrmEntity>> get(int id) async {
    final token = await _sessionDataProvider.crmApiKey();
    if (token == null) return left(Failure(FailureMessages.emptyApiKey));

    return await _cashRegisterCrmDataProvider.get(token, id);
  }

  @override
  Future<Either<Failure, List<CashRegisterCrmEntity>>> registers() async {
    final token = await _sessionDataProvider.crmApiKey();
    if (token == null) return left(Failure(FailureMessages.emptyApiKey));

    return await _cashRegisterCrmDataProvider.registers(token);
  }

  @override
  Future<Either<Failure, List<CashRegisterTypeCrmEntity>>> types() async {
    final token = await _sessionDataProvider.crmApiKey();
    if (token == null) return left(Failure(FailureMessages.emptyApiKey));

    return await _cashRegisterCrmDataProvider.types(token);
  }

  @override
  Future<Either<Failure, CashRegisterCrmEntity>> add(
    String title,
    int typeId,
  ) async {
    final token = await _sessionDataProvider.crmApiKey();
    if (token == null) return left(Failure(FailureMessages.emptyApiKey));

    return await _cashRegisterCrmDataProvider.add(token, title, typeId);
  }
}
