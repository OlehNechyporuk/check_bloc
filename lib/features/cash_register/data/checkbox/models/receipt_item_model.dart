import 'package:json_annotation/json_annotation.dart';

import 'package:check_bloc/features/cash_register/data/checkbox/models/discount_model.dart';
import 'package:check_bloc/features/cash_register/data/checkbox/models/good_model.dart';
import 'package:check_bloc/features/cash_register/domain/entity/receipt_item_entity.dart';

part 'receipt_item_model.g.dart';

@JsonSerializable()
class ReceiptItemModel extends ReceiptItemEntity {
  @JsonKey(name: 'good')
  final GoodModel goodModel;
  @JsonKey(name: 'discounts')
  final List<DiscountModel> discounstModel;

  const ReceiptItemModel({
    required super.id,
    required this.goodModel,
    required super.quantity,
    required this.discounstModel,
  }) : super(
          good: goodModel,
          discounts: discounstModel,
        );

  factory ReceiptItemModel.fromJson(Map<String, dynamic> json) =>
      _$ReceiptItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReceiptItemModelToJson(this);
}
