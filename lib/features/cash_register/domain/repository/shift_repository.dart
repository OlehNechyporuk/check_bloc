import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/features/cash_register/domain/entity/receipt_entity.dart';
import 'package:check_bloc/features/cash_register/domain/entity/shift_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

abstract class ShiftRepository {
  const ShiftRepository();

  Future<Either<Failure, List<ShiftEntity>>> shifts(
    DateTimeRange dateTimeRange,
    int limit,
    int offset,
  );
  Future<Either<Failure, ShiftEntity>> open();
  Future<Either<Failure, ShiftEntity>> get();
  Future<Either<Failure, ReceiptEntity>> close();
  Future<Either<Failure, ReceiptEntity>> cashIn(double sum);
  Future<Either<Failure, ReceiptEntity>> cashOut(double sum);
}
