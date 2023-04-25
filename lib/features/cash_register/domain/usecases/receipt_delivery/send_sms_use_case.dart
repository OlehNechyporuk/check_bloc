import 'package:dartz/dartz.dart';

import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/core/usecases/usecase.dart';
import 'package:check_bloc/features/cash_register/domain/repository/receipt_repository.dart';

class SendSmsUseCase extends UseCase<bool, SendSmsParams> {
  final ReceiptRepository _receiptRepository;

  const SendSmsUseCase(this._receiptRepository);
  @override
  Future<Either<Failure, bool>> call(SendSmsParams params) async {
    return await _receiptRepository.sendSms(params.receiptId, params.phone);
  }
}

class SendSmsParams {
  final String receiptId;
  final String phone;

  const SendSmsParams(this.receiptId, this.phone);
}
