import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/features/cash_register/domain/entity/cash_register_entity.dart';
import 'package:dartz/dartz.dart';

abstract class CashRegisterRepository {
  const CashRegisterRepository();
  Future<Either<Failure, CashRegisterEntity>> info();
  Future<String?> getLicenseKey();
  Future<void> saveLicenseKey(String key);
  Future<void> daleteLicenseKey();
}
