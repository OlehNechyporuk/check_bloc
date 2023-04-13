import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/domain/entity/receipt_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ReceiptRepository {
  const ReceiptRepository();
  Future<Either<Failure, ReceiptEntity>> add(ReceiptEntity receipt);
  Future<Either<Failure, List<ReceiptEntity>>> receipts();
  Future<Either<Failure, bool>> sendEmail(String receiptId, String email);
  Future<Either<Failure, bool>> sendSms(String receiptId, String phone);
}
