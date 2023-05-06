import 'package:dartz/dartz.dart';

import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/features/cash_register/domain/entity/report_entity.dart';

abstract class ReportRepository {
  const ReportRepository();

  Future<Either<Failure, List<ReportEntity>>> reports();
  Future<Either<Failure, ReportEntity>> createXreport();
  Future<Either<Failure, String>> get(String id);
}
