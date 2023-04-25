import 'package:dartz/dartz.dart';

import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/core/usecases/usecase.dart';
import 'package:check_bloc/features/cash_register/domain/repository/receipt_repository.dart';

class SendEmailUseCase extends UseCase<bool, SendEmailParams> {
  final ReceiptRepository _receiptRepository;

  const SendEmailUseCase(this._receiptRepository);

  @override
  Future<Either<Failure, bool>> call(SendEmailParams params) async {
    return await _receiptRepository.sendEmail(params.receiptId, params.email);
  }
}

class SendEmailParams {
  final String receiptId;
  final String email;

  const SendEmailParams(this.receiptId, this.email);
}
