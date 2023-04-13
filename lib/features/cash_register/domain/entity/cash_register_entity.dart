import 'package:equatable/equatable.dart';

class CashRegisterEntity extends Equatable {
  final String id;
  final String fiscalNumber;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int? number;
  final String? address;
  final String? title;
  final bool? offlineMode;
  final bool? stayOffline;
  final bool? hasShift;
  final Map<String, dynamic>? documentsState;
  final DateTime? emergencyDate;
  final String? emergencyDetails;

  const CashRegisterEntity({
    required this.id,
    required this.fiscalNumber,
    required this.createdAt,
    required this.updatedAt,
    required this.number,
    required this.address,
    required this.title,
    required this.offlineMode,
    required this.stayOffline,
    required this.hasShift,
    required this.documentsState,
    required this.emergencyDate,
    required this.emergencyDetails,
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
}
