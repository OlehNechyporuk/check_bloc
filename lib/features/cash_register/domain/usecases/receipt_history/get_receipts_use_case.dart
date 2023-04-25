import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/core/usecases/usecase.dart';
import 'package:check_bloc/features/cash_register/domain/entity/receipt_entity.dart';
import 'package:check_bloc/features/cash_register/domain/repository/receipt_repository.dart';
import 'package:dartz/dartz.dart';

class GetReceiptsUseCase extends UseCase<List<ReceiptEntity>, NoParams> {
  final ReceiptRepository _receiptRepository;

  const GetReceiptsUseCase(this._receiptRepository);

  @override
  Future<Either<Failure, List<ReceiptEntity>>> call(NoParams params) async {
    return await _receiptRepository.receipts();
  }
}
