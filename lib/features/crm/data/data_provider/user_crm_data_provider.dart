import 'dart:convert';

import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/features/crm/data/models/user_model.dart';
import 'package:check_bloc/features/crm/domain/entity/user_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class UserCrmDataProvider {
  final http.Client _client;

  const UserCrmDataProvider(this._client);

  Future<Either<Failure, UserEntity>> get(String token) async {
    await Future.delayed(const Duration(seconds: 1));
    return right(
      UserModel.fromJson(
        jsonDecode('''{
      "id": 1,
      "phone": "380993239923",
      "first_name": "Oleh",
      "middle_name": null,
      "last_name" : "Nechyporuk",
      "email": "admin@gmail.com",
      "roles": ["ROLE_OWNER"],
      "status": 1,
      "created": "2023-03-03 14:23:33",
      "avatar": null,
      "verified": true
    }'''),
      ),
    );
  }
}
