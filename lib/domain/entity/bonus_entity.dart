import 'package:equatable/equatable.dart';

class BonusEntity extends Equatable {
  final String id;
  const BonusEntity({required this.id});

  @override
  List<Object> get props => [id];
}
