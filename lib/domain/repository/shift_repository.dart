import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/domain/entity/receipt_entity.dart';
import 'package:check_bloc/domain/entity/shift_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ShiftRepository {
  const ShiftRepository();

  Future<Either<Failure, ShiftEntity>> open();
  Future<Either<Failure, ShiftEntity>> get();
  Future<Either<Failure, ReceiptEntity>> close();
  Future<Either<Failure, ReceiptEntity>> cashIn(double sum);
  Future<Either<Failure, ReceiptEntity>> cashOut(double sum);
}
