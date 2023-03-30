import 'package:check_bloc/domain/entity/shift.dart';

abstract class ShiftRepository {
  const ShiftRepository();

  Future<Shift?> open();
  Future<Shift?> get();
  Future<void> close();
  Future<void> cashIn(double sum);
  Future<void> cashOut(double sum);
}
