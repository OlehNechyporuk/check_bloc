import 'package:equatable/equatable.dart';

class SubEntity extends Equatable {
  final int id;
  final int company;
  final DateTime created;
  final DateTime end;

  const SubEntity({
    required this.id,
    required this.company,
    required this.created,
    required this.end,
  });

  @override
  List<Object> get props => [id, company, created, end];
}
