import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/features/cash_register/domain/entity/report_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ReportRepository {
  Future<Either<Failure, List<ReportEntity>>> reports();
  Future<Either<Failure, ReportEntity>> createXreport();
}
