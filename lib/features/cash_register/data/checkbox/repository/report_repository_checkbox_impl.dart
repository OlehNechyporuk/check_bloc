import 'package:check_bloc/features/cash_register/data/checkbox/data_provider/checkbox_api_data_provider.dart';
import 'package:check_bloc/features/cash_register/data/checkbox/data_provider/session_data_provider.dart';
import 'package:check_bloc/features/cash_register/domain/entity/report_entity.dart';
import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/features/cash_register/domain/repository/report_repository.dart';
import 'package:dartz/dartz.dart';

class ReportRepositoryCheckboxImpl extends ReportRepository {
  final SessionDataProvider _dataProvider;
  final CheckboxApiDataProvider _apiProvider;

  const ReportRepositoryCheckboxImpl(this._dataProvider, this._apiProvider);

  @override
  Future<Either<Failure, ReportEntity>> createXreport() {
    // TODO: implement createXreport
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> get(String id) async {
    final apiKey = await _dataProvider.apiKey();
    return _apiProvider.getReport(apiKey, id);
  }

  @override
  Future<Either<Failure, List<ReportEntity>>> reports() {
    // TODO: implement reports
    throw UnimplementedError();
  }
}
