import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/domain/entity/cash_register.dart';
import 'package:dartz/dartz.dart';

abstract class CashRegisterRepository {
  const CashRegisterRepository();
  Future<Either<Failure, CashRegister>> info();
  Future<String?> getLicenseKey();
  Future<void> saveLicenseKey(String key);
  Future<void> daleteLicenseKey();
}
