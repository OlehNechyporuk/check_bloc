// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bonus.g.dart';

@JsonSerializable()
class Bonus extends Equatable {
  final String? id;
  const Bonus({
    this.id,
  });

  @override
  List<Object?> get props => [id];

  factory Bonus.fromJson(Map<String, dynamic> json) => _$BonusFromJson(json);

  Map<String, dynamic> toJson() => _$BonusToJson(this);
}
