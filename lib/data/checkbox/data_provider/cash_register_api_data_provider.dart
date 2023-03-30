import 'dart:convert';

import 'package:check_bloc/config/constants.dart';
import 'package:check_bloc/domain/entity/cash_register.dart';
import 'package:http/http.dart' as http;

class CashRegisterApiDataProvider {
  const CashRegisterApiDataProvider();

  Future<CashRegister?> getInfo(String key, String licence) async {
    var url = Uri.parse('${AppConstants.checkboxApiServer}cash-registers/info');

    try {
      var response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          AppConstants.checkboxTokenName: 'Bearer $key',
          AppConstants.checkboxRegisterLicenseName: licence,
        },
      );
      if (response.statusCode == 200) {
        final body = jsonDecode(utf8.decode(response.bodyBytes));
        return CashRegister.fromJson(body);
      }
    } catch (e) {}
    return null;
  }
}
