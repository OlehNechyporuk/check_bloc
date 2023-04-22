import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/features/crm/domain/entity/cash_register_crm_entity.dart';
import 'package:check_bloc/features/crm/domain/entity/cash_register_crm_type.dart';
import 'package:dartz/dartz.dart';

abstract class CashRegisterCrmRepository {
  const CashRegisterCrmRepository();

  Future<Either<Failure, List<CashRegisterCrmEntity>>> registers();
  Future<Either<Failure, CashRegisterCrmEntity>> get(int id);
  Future<Either<Failure, List<CashRegisterTypeCrmEntity>>> types();
  Future<Either<Failure, CashRegisterCrmEntity>> add(
    String title,
    int typeId,
  );
}
