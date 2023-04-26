import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/core/usecases/usecase.dart';
import 'package:check_bloc/features/cash_register/domain/entity/receipt_entity.dart';
import 'package:check_bloc/features/cash_register/domain/repository/receipt_repository.dart';
import 'package:dartz/dartz.dart';

class AddReceiptUseCase extends UseCase<ReceiptEntity, AddReceiptParams> {
  final ReceiptRepository _receiptRepository;

  const AddReceiptUseCase(this._receiptRepository);
  @override
  Future<Either<Failure, ReceiptEntity>> call(AddReceiptParams params) async {
    return await _receiptRepository.add(params.receipt);
  }
}

class AddReceiptParams {
  final ReceiptEntity receipt;

  const AddReceiptParams({required this.receipt});
}
