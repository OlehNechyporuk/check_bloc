import 'package:check_bloc/domain/entity/receipt.dart';

abstract class ReceiptRepository {
  const ReceiptRepository();
  Future<Receipt?> add(Receipt receipt);
  Future<List<Receipt>?> receipts();
  Future<String?> getHtml(String id);
}
