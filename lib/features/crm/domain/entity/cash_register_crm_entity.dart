import 'package:equatable/equatable.dart';

import 'package:check_bloc/features/crm/domain/entity/cash_register_crm_type.dart';

class CashRegisterCrmEntity extends Equatable {
  final int id;
  final String title;
  final CashRegisterTypeCrmEntity type;

  const CashRegisterCrmEntity({
    required this.id,
    required this.title,
    required this.type,
  });

  @override
  List<Object> get props => [id, title, type];
}
