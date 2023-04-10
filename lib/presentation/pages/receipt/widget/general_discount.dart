import 'package:check_bloc/domain/entity/discount.dart';
import 'package:check_bloc/presentation/blocs/receipt_bloc/receipt_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GeneralDiscount extends StatefulWidget {
  final Map<String, dynamic>? info;

  const GeneralDiscount({super.key, required this.info});

  @override
  State<GeneralDiscount> createState() => _GeneralDiscountState();
}

class _GeneralDiscountState extends State<GeneralDiscount> {
  DiscountType? type = DiscountType.percent;
  double? value;

  updateDiscountMode(DiscountType? value) {
    type = value;
    setState(() {});
  }

  update(val) {
    setState(() {
      value = double.tryParse(val);
    });
  }

  DiscountType? get currentType {
    return type;
  }

  double? get currentValue {
    return value;
  }

  bool get isValid {
    final double? val = double.tryParse(value.toString());

    if (type == null) {
      return false;
    }

    if (val == null) {
      return true;
    }

    if (type == DiscountType.percent) {
      if (val > 0 && val < 100) {
        return true;
      } else {
        return false;
      }
    } else if (type == DiscountType.fixed) {
      final price = widget.info?['sum'] ?? 0;

      if ((val * 100) >= price) {
        return false;
      }
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    final discounts =
        context.read<ReceiptBloc>().state.receipt?.discounts ?? [];

    if (discounts.isNotEmpty) {
      type = discounts.first.discountMode;
      if (type == DiscountType.fixed) {
        value = discounts.first.value?.toDouble() ?? 0;
      } else {
        value = discounts.first.value?.toDouble();
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('${AppLocalizations.of(context)?.generalReceiptDiscount}: '),
        _DiscountInput(
          discount: value,
          currentType: currentType,
          updateValue: update,
          isValid: isValid,
        ),
        _DiscountType(
          type: type ?? DiscountType.percent,
          updateDiscountType: updateDiscountMode,
          currentValue: currentValue,
        ),
      ],
    );
  }
}

class _DiscountInput extends StatelessWidget {
  final double? discount;
  final DiscountType? currentType;
  final Function updateValue;
  final bool isValid;
  const _DiscountInput({
    required this.discount,
    required this.currentType,
    required this.updateValue,
    required this.isValid,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 44,
      child: TextFormField(
        initialValue: '${discount?.toString()}',
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          errorStyle: const TextStyle(
            height: 0,
          ),
          filled: true,
          fillColor: Colors.white,
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 0,
            horizontal: 0,
          ),
          errorText: isValid ? null : '',
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
        ],
        onChanged: (value) {
          updateValue(value);
          context.read<ReceiptBloc>().add(
                ReceiptAddGeneralDiscountEvent(
                  type: currentType,
                  discount: double.tryParse(value),
                ),
              );
        },
      ),
    );
  }
}

class _DiscountType extends StatelessWidget {
  final DiscountType? type;
  final double? currentValue;
  final Function updateDiscountType;
  const _DiscountType({
    required this.type,
    required this.updateDiscountType,
    required this.currentValue,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      child: Column(
        children: [
          Row(
            children: [
              Radio<DiscountType>(
                visualDensity: const VisualDensity(
                  horizontal: VisualDensity.minimumDensity,
                  vertical: VisualDensity.minimumDensity,
                ),
                value: DiscountType.percent,
                groupValue: type,
                onChanged: (DiscountType? type) {
                  updateDiscountType(type);
                  context.read<ReceiptBloc>().add(
                        ReceiptAddGeneralDiscountEvent(
                          type: type,
                          discount: currentValue,
                        ),
                      );
                },
              ),
              const Text('%'),
            ],
          ),
          Row(
            children: [
              Radio<DiscountType>(
                visualDensity: const VisualDensity(
                  horizontal: VisualDensity.minimumDensity,
                  vertical: VisualDensity.minimumDensity,
                ),
                value: DiscountType.fixed,
                groupValue: type,
                onChanged: (DiscountType? type) {
                  updateDiscountType(type);
                  context.read<ReceiptBloc>().add(
                        ReceiptAddGeneralDiscountEvent(
                          type: type,
                          discount: currentValue,
                        ),
                      );
                },
              ),
              const Text('₴'),
            ],
          ),
        ],
      ),
    );
  }
}
