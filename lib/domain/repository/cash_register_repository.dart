import 'package:check_bloc/domain/entity/cash_register.dart';

abstract class CashRegisterRepository {
  const CashRegisterRepository();
  Future<CashRegister?> getCashRegisterInfo();
  Future<String?> getLicenseKey();
  Future<void> saveLicenseKey(String key);
  Future<void> daleteLicenseKey();
}
