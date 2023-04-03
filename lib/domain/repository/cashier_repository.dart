import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/domain/entity/cashier.dart';
import 'package:dartz/dartz.dart';

abstract class CashierRepositry {
  const CashierRepositry();

  Future<Either<Failure, Cashier>> info();
}
