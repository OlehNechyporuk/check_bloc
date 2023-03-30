import 'dart:convert';

import 'package:check_bloc/config/constants.dart';
import 'package:check_bloc/domain/entity/product.dart';
import 'package:http/http.dart' as http;

class ProductApiDataProvider {
  const ProductApiDataProvider();

  Future<List<Product>> getProudcts(
      {required String key,
      int limit = AppConstants.productsLimitPerPage,
      int offest = 0,
      String? query}) async {
    var params = '?limit=$limit&offset=$offest';

    if (query != null && query.isNotEmpty) {
      params += '&query=$query';
    }

    var url = Uri.parse('${AppConstants.checkboxApiServer}goods$params');

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
        final jsonProducts = body['results'] as List;

        final result = jsonProducts.map((e) {
          return Product.fromJson(e);
        });

        return result.toList();
      }
    } catch (e) {}
    return [];
  }
}
