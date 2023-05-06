import 'package:dartz/dartz.dart';

import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/core/usecases/usecase.dart';
import 'package:check_bloc/features/cash_register/domain/repository/report_repository.dart';

class GetReportUseCase extends UseCase<String, ReportUseCaseParams> {
  final ReportRepository _reportRepository;

  const GetReportUseCase(this._reportRepository);

  @override
  Future<Either<Failure, String>> call(ReportUseCaseParams params) async {
    return await _reportRepository.get(params.id);
  }
}

class ReportUseCaseParams {
  final String id;
  const ReportUseCaseParams(this.id);
}
