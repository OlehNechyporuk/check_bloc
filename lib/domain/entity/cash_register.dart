import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cash_register.g.dart';

@JsonSerializable()
class CashRegister extends Equatable {
  final String? id;
  @JsonKey(name: 'fiscal_number')
  final String? fiscalNumber;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  @JsonStringToInt()
  final int? number;
  final String? address;
  final String? title;
  @JsonKey(name: 'offline_mode')
  final bool? offlineMode;
  @JsonKey(name: 'stay_offline')
  final bool? stayOffline;
  @JsonKey(name: 'has_shift')
  final bool? hasShift;
  @JsonKey(name: 'documents_state')
  final Map<String, dynamic>? documentsState;
  @JsonKey(name: 'emergency_date')
  final DateTime? emergencyDate;
  @JsonKey(name: 'emergency_details')
  final String? emergencyDetails;

  const CashRegister({
    this.id,
    this.fiscalNumber,
    this.createdAt,
    this.updatedAt,
    this.number,
    this.address,
    this.title,
    this.offlineMode,
    this.stayOffline,
    this.hasShift,
    this.documentsState,
    this.emergencyDate,
    this.emergencyDetails,
  });

  @override
  List<Object?> get props {
    return [
      id,
      fiscalNumber,
      createdAt,
      updatedAt,
      number,
      address,
      title,
      offlineMode,
      stayOffline,
      hasShift,
      documentsState,
      emergencyDate,
      emergencyDetails,
    ];
  }

  factory CashRegister.fromJson(Map<String, dynamic> json) =>
      _$CashRegisterFromJson(json);
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
