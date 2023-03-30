import 'package:check_bloc/domain/entity/cashier.dart';

abstract class CashierRepositry {
  const CashierRepositry();
  Future<Cashier?> loadInfo();
}
