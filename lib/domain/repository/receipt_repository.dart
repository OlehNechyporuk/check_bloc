import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/domain/entity/receipt.dart';
import 'package:dartz/dartz.dart';

abstract class ReceiptRepository {
  const ReceiptRepository();
  Future<Receipt?> add(Receipt receipt);
  Future<Either<Failure, List<Receipt>>> receipts();
  Future<String?> getHtml(String id);
}
