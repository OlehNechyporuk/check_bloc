import 'package:check_bloc/domain/entity/cash_register_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cash_register_model.g.dart';

@JsonSerializable()
class CashRegisterModel extends CashRegisterEntity {
  @JsonStringToInt()
  @JsonKey(name: 'number')
  final int? convertNumber;

  const CashRegisterModel({
    required super.id,
    required super.fiscalNumber,
    required super.createdAt,
    required super.updatedAt,
    required this.convertNumber,
    required super.address,
    required super.title,
    required super.offlineMode,
    required super.stayOffline,
    required super.hasShift,
    required super.documentsState,
    required super.emergencyDate,
    required super.emergencyDetails,
  }) : super(number: convertNumber);

  factory CashRegisterModel.fromJson(Map<String, dynamic> json) =>
      _$CashRegisterModelFromJson(json);

  Map<String, dynamic> toJson() => _$CashRegisterModelToJson(this);
}

class JsonStringToInt implements JsonConverter<int, dynamic> {
  const JsonStringToInt();

  @override
  int fromJson(dynamic json) {
    if (json is num) {
      return json.toInt();
    }
    return int.tryParse(json) ?? 0;
  }

  @override
  String toJson(int object) => object.toString();
}
