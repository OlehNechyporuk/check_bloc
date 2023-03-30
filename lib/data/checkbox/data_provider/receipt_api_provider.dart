import 'dart:convert';

import 'package:check_bloc/config/constants.dart';
import 'package:check_bloc/domain/entity/receipt.dart';
import 'package:http/http.dart' as http;

class ReceiptApiProvider {
  const ReceiptApiProvider();

  Future<Receipt?> add(String apiKey, Receipt receipt) async {
    var url = Uri.parse('${AppConstants.checkboxApiServer}receipts/sell');

    try {
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          AppConstants.checkboxTokenName: 'Bearer $apiKey',
        },
        body: jsonEncode(receipt),
      );

      if (response.statusCode == 201) {
        final body = jsonDecode(utf8.decode(response.bodyBytes));

        return Receipt.fromJson(body);
      }
    } catch (e) {}
    return null;
  }

  Future<List<Receipt>?> receipts(String apiKey) async {
    var url = Uri.parse(
        '${AppConstants.checkboxApiServer}receipts/search/?&desc=true');
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
        final jsonReceipts = body['results'] as List;

        final result = jsonReceipts.map((e) {
          return Receipt.fromJson(e);
        });

        return result.toList();
      }
    } catch (e) {}
    return null;
  }

  Future<String?> getHtml(String apiKey, String id) async {
    var url = Uri.parse('${AppConstants.checkboxApiServer}receipts/$id/html');

    try {
      var response = await http.get(
        url,
      );

      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {}
    return null;
  }
}
