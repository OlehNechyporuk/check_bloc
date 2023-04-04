import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/domain/entity/receipt.dart';
import 'package:check_bloc/domain/entity/shift.dart';
import 'package:dartz/dartz.dart';

abstract class ShiftRepository {
  const ShiftRepository();

  Future<Either<Failure, Shift>> open();
  Future<Either<Failure, Shift>> get();
  Future<Either<Failure, Receipt>> close();
  Future<Either<Failure, Receipt>> cashIn(double sum);
  Future<Either<Failure, Receipt>> cashOut(double sum);
}
