import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/domain/entity/receipt.dart';
import 'package:dartz/dartz.dart';

abstract class ReceiptRepository {
  const ReceiptRepository();
  Future<Either<Failure, Receipt>> add(Receipt receipt);
  Future<Either<Failure, List<Receipt>>> receipts();
  Future<Either<Failure, bool>> sendEmail(String receiptId, String email);
  Future<Either<Failure, bool>> sendSms(String receiptId, String phone);
}
