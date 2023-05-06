import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/core/usecases/usecase.dart';
import 'package:check_bloc/features/cash_register/domain/entity/shift_entity.dart';
import 'package:check_bloc/features/cash_register/domain/repository/shift_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class GetShiftsUseCase
    extends UseCase<List<ShiftEntity>, ShiftsPaginationsParams> {
  final ShiftRepository _shiftRepository;

  const GetShiftsUseCase(this._shiftRepository);

  @override
  Future<Either<Failure, List<ShiftEntity>>> call(
    ShiftsPaginationsParams params,
  ) async {
    return await _shiftRepository.shifts(
      params.dateTimeRange,
      params.limit,
      params.offset,
    );
  }
}

class ShiftsPaginationsParams {
  final DateTimeRange dateTimeRange;
  final int limit;
  final int offset;

  const ShiftsPaginationsParams({
    required this.dateTimeRange,
    required this.limit,
    required this.offset,
  });
}
