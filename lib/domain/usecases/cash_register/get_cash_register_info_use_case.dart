import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/core/usecases/usecase.dart';
import 'package:check_bloc/domain/entity/cash_register_entity.dart';
import 'package:check_bloc/domain/repository/cash_register_repository.dart';
import 'package:dartz/dartz.dart';

class GetCashRegisterInfoUseCase
    implements UseCase<CashRegisterEntity, NoParams> {
  final CashRegisterRepository _registerRepository;

  const GetCashRegisterInfoUseCase(this._registerRepository);

  @override
  Future<Either<Failure, CashRegisterEntity>> call(NoParams params) async {
    return await _registerRepository.info();
  }
}
