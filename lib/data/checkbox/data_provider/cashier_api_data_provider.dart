import 'dart:convert';

import 'package:check_bloc/config/constants.dart';
import 'package:check_bloc/domain/entity/cashier.dart';
import 'package:http/http.dart' as http;

class CashierApiDataProvider {
  const CashierApiDataProvider();

  Future<Cashier?> getInfo(String key) async {
    var url = Uri.parse('${AppConstants.checkboxApiServer}cashier/me');
    try {
      var response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          AppConstants.checkboxTokenName: 'Bearer $key',
        },
      );
      if (response.statusCode == 200) {
        final body = jsonDecode(utf8.decode(response.bodyBytes));
        return Cashier.fromJson(body);
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }
}
