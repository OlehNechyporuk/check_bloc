import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/domain/entity/cashier_etity.dart';
import 'package:dartz/dartz.dart';

abstract class CashierRepository {
  const CashierRepository();

  Future<Either<Failure, CashierEntity>> info();
}
