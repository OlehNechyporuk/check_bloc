import 'dart:convert';

import 'package:check_bloc/config/constants.dart';
import 'package:check_bloc/domain/entity/receipt_payment.dart';
import 'package:check_bloc/domain/entity/shift.dart';
import 'package:http/http.dart' as http;

class ShiftApiDataProvider {
  const ShiftApiDataProvider();

  Future<Shift?> open(String apiKey, String licenceKey) async {
    var url = Uri.parse('${AppConstants.checkboxApiServer}shifts');

    try {
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          AppConstants.checkboxTokenName: 'Bearer $apiKey',
          AppConstants.checkboxRegisterLicenseName: licenceKey,
        },
      );
      if (response.statusCode == 202) {
        final body = jsonDecode(utf8.decode(response.bodyBytes));
        return Shift.fromJson(body);
      }
    } catch (e) {}
    return null;
  }

  Future<Shift?> get(String apiKey) async {
    var url = Uri.parse('${AppConstants.checkboxApiServer}cashier/shift');

    try {
      var response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          AppConstants.checkboxTokenName: 'Bearer $apiKey',
        },
      );
      if (response.statusCode == 200) {
        final body = jsonDecode(utf8.decode(response.bodyBytes));

        if (body == null) {
          return null;
        }

        return Shift.fromJson(body);
      }
    } catch (e) {}
    return null;
  }

  Future<void> close(String apiKey) async {
    var url = Uri.parse('${AppConstants.checkboxApiServer}shifts/close');

    try {
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          AppConstants.checkboxTokenName: 'Bearer $apiKey',
        },
      );
      if (response.statusCode == 200) {
        final body = jsonDecode(utf8.decode(response.bodyBytes));
      }
    } catch (e) {}
  }

  Future<void> cashReceiptService(String apiKey, ReceiptPayment payment) async {
    var url = Uri.parse('${AppConstants.checkboxApiServer}receipts/service');

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          AppConstants.checkboxTokenName: 'Bearer $apiKey',
        },
        body: jsonEncode({'payment': payment}),
      );
      if (response.statusCode == 201) {
        final body = jsonDecode(utf8.decode(response.bodyBytes));
      }
    } catch (e) {}
  }
}
