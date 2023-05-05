import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/features/cash_register/domain/entity/receipt_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

abstract class ReceiptRepository {
  const ReceiptRepository();
  Future<Either<Failure, ReceiptEntity>> add(ReceiptEntity receipt);
  Future<Either<Failure, List<ReceiptEntity>>> receipts({
    required DateTimeRange? dateTimeRange,
    required int offset,
  });
  Future<Either<Failure, bool>> sendEmail(String receiptId, String email);
  Future<Either<Failure, bool>> sendSms(String receiptId, String phone);
}
