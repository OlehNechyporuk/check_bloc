import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/core/usecases/usecase.dart';
import 'package:check_bloc/features/cash_register/domain/entity/cashier_etity.dart';
import 'package:check_bloc/features/cash_register/domain/repository/cashier_repository.dart';
import 'package:dartz/dartz.dart';

class GetCashierUseCase extends UseCase<CashierEntity, NoParams> {
  final CashierRepository _repositry;

  const GetCashierUseCase(this._repositry);
  @override
  Future<Either<Failure, CashierEntity>> call(NoParams params) async {
    return await _repositry.info();
  }
}
