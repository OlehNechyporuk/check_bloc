import 'dart:convert';

import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/features/crm/data/models/cash_register_crm_model.dart';
import 'package:check_bloc/features/crm/data/models/cash_register_type_crm_model.dart';
import 'package:check_bloc/features/crm/domain/entity/cash_register_crm_entity.dart';
import 'package:check_bloc/features/crm/domain/entity/cash_register_crm_type.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class CashRegisterCrmDataProvider {
  final http.Client _client;

  const CashRegisterCrmDataProvider(this._client);

  Future<Either<Failure, List<CashRegisterTypeCrmEntity>>> types(
    String token,
  ) async {
    await Future.delayed(const Duration(seconds: 1));

    const json = '''[{
      "id": 1,
      "title": "Checkbox",
      "logo": "Checkbox",
      "status": "ON"
    }]''';

    final list = jsonDecode(json) as List;

    final result = list.map((e) {
      return CashRegisterTypeCrmModel.fromJson(e);
    });

    return right(result.toList());
  }

  Future<Either<Failure, List<CashRegisterCrmEntity>>> registers(
    String token,
  ) async {
    await Future.delayed(const Duration(seconds: 1));
    const json = '''[
      {
        "id" : 1,
        "title" : "Тестова каса",
        "type" : {
      "id": 1,
      "title": "Checkbox",
      "logo": "Checkbox",
      "status": "ON"
    }
      },
       {
        "id" : 2,
        "title" : "Тестова 2",
        "type" : {
      "id": 2,
      "title": "CustomCheck",
      "logo": "CustomCheck",
      "status": "ON"
    }
      }
    ]''';

    final list = jsonDecode(json) as List;

    final result = list.map((e) {
      return CashRegisterCrmModel.fromJson(e);
    });

    return right(result.toList());
  }

  Future<Either<Failure, CashRegisterCrmEntity>> get(
    String token,
    int id,
  ) async {
    await Future.delayed(const Duration(seconds: 1));
    const json = '''[
        "id" : 1,
        "title" : "Тестова каса",
        "type" : {
          "id": 1,
      "title": "Checkbox",
      "logo": "Checkbox",
      "status": "ON"
        }
     ]''';

    return right(CashRegisterCrmModel.fromJson(jsonDecode(json)));
  }

  Future<Either<Failure, CashRegisterCrmEntity>> add(
    String token,
    String title,
    int typeId,
  ) async {
    await Future.delayed(const Duration(seconds: 1));

    final json = '''{
        "id" : 1,
        "title" : "$title",
        "type" : {
          "id": 1,
      "title": "Checkbox",
      "logo": "Checkbox",
      "status": "ON"
        }
     }''';

    return right(CashRegisterCrmModel.fromJson(jsonDecode(json)));
  }
}
