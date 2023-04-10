import 'dart:math';

import 'package:intl/intl.dart';

extension DoubleExt on double {
  String toUAH() {
    return NumberFormat.simpleCurrency(
      name: '',
    ).format((this / 100));
  }
}

extension DoubleRoundedExt on double {
  String toRoundedUAH() {
    num mod = pow(10.0, 1);
    return NumberFormat.simpleCurrency(
      name: '',
    ).format((((this / 100) * mod).round().toDouble() / mod));
  }
}

extension DateUkraine on DateTime {
  String toLocalTime() {
    var formatter = DateFormat.yMd('uk').add_Hms();
    return formatter.format(toLocal());
  }
}
