import 'package:equatable/equatable.dart';

class CashRegisterTypeCrmEntity extends Equatable {
  final int id;
  final String title;
  final String logo;
  final String status;

  const CashRegisterTypeCrmEntity({
    required this.id,
    required this.title,
    required this.logo,
    required this.status,
  });

  @override
  List<Object> get props => [id, title, logo, status];
}
