import 'dart:convert';
import 'dart:io';

import 'package:check_bloc/config/constants.dart';
import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/data/checkbox/models/product_model.dart';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class ProductApiDataProvider {
  final http.Client _client;

  const ProductApiDataProvider(this._client);

  Future<Either<Failure, List<ProductModel>>> getProudcts({
    required String key,
    int limit = AppConstants.productsLimitPerPage,
    int offest = 0,
    String? query,
  }) async {
    var params = '?limit=$limit&offset=$offest';

    if (query != null && query.isNotEmpty) {
      params += '&query=$query';
    }

    try {
      var url = Uri.parse('${AppConstants.checkboxApiServer}goods$params');
      var response = await _client.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          AppConstants.checkboxTokenName: 'Bearer $key',
        },
      );

      final body = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        final jsonProducts = body['results'] as List;

        final result = jsonProducts.map((e) {
          return ProductModel.fromJson(e);
        });

        return right(result.toList());
      } else {
        return left(
          Failure(body['message'] ?? FailureMessages.noServerResponseMessage),
        );
      }
    } on SocketException {
      return left(Failure(FailureMessages.noInternetConnection));
    } on HttpException catch (e) {
      return left(Failure(e.message));
    } on FormatException {
      return left(Failure(FailureMessages.badResponseFormat));
    } catch (e) {
      rethrow;
    }
  }
}
