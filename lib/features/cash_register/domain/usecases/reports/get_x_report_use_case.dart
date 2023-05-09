import 'package:dartz/dartz.dart';

import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/core/usecases/usecase.dart';
import 'package:check_bloc/features/cash_register/domain/entity/report_entity.dart';
import 'package:check_bloc/features/cash_register/domain/repository/report_repository.dart';

class GetXReportUseCase extends UseCase<ReportEntity, NoParams> {
  final ReportRepository _reportRepository;

  const GetXReportUseCase(this._reportRepository);

  @override
  Future<Either<Failure, ReportEntity>> call(NoParams params) async {
    return await _reportRepository.createXreport();
  }
}
