import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/core/usecases/usecase.dart';
import 'package:check_bloc/features/cash_register/data/checkbox/data_provider/session_data_provider.dart';
import 'package:dartz/dartz.dart';

class ChangeCurrentCashRegisterUseCase extends UseCase<bool, String> {
  final SessionDataProvider _dataProvider;

  const ChangeCurrentCashRegisterUseCase(this._dataProvider);

  @override
  Future<Either<Failure, bool>> call(String params) async {
    await _dataProvider.saveCurrentCashRegister(params);
    return right(true);
  }
}
