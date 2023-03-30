import 'package:check_bloc/domain/entity/discount.dart';
import 'package:check_bloc/domain/entity/receipt_item.dart';
import 'package:check_bloc/main.dart';
import 'package:check_bloc/presentation/blocs/receipt_bloc/receipt_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemRowDiscountWidget extends StatefulWidget {
  final ReceiptItem item;
  final int index;

  const ItemRowDiscountWidget({
    super.key,
    required this.item,
    required this.index,
  });

  @override
  State<ItemRowDiscountWidget> createState() => ItemRowDiscountWidgetState();
}

class ItemRowDiscountWidgetState extends State<ItemRowDiscountWidget> {
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
      final price = widget.item.good?.price ?? 0;

      if ((val * 100) >= price) {
        return false;
      }
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    final discounts = context
            .read<ReceiptBloc>()
            .state
            .receipt
            ?.goods?[widget.index]
            .discounts ??
        [];

    if (discounts.isNotEmpty) {
      type = discounts.first.discountMode;
      if (type == DiscountType.fixed) {
        value = discounts.first.value?.toDouble() ?? 0;
      } else {
        value = discounts.first.value?.toDouble();
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Title(title: '${widget.item.good?.name}'),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _PriceWidget(widget: widget),
            const SizedBox(width: 5),
            _DiscountInput(
              widget: widget,
              isValid: isValid,
              callback: update,
              type: currentType,
              currentValue: value,
            ),
            const SizedBox(width: 5),
            _DiscountType(
              widget,
              updateDiscountMode,
              type,
              isValid,
              currentValue,
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class _Title extends StatelessWidget {
  final String? title;
  const _Title({this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      '$title',
      style: const TextStyle(
        fontSize: 16,
      ),
    );
  }
}

class _DiscountInput extends StatelessWidget {
  final ItemRowDiscountWidget? widget;
  final Function callback;
  final bool isValid;
  final DiscountType? type;
  final double? currentValue;

  const _DiscountInput({
    this.widget,
    required this.isValid,
    required this.callback,
    required this.type,
    required this.currentValue,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 44,
      child: TextFormField(
        initialValue: currentValue?.toString() ?? '',
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
          callback(value);
          context.read<ReceiptBloc>().add(
                ReceiptAddDiscountToProductEvent(
                  index: widget!.index,
                  discount: double.tryParse(value),
                  type: type ?? DiscountType.percent,
                ),
              );
        },
      ),
    );
  }
}

class _PriceWidget extends StatelessWidget {
  final ItemRowDiscountWidget widget;
  const _PriceWidget({required this.widget});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Text(
        '${widget.item.good?.price?.toUAH()} ₴',
        style: const TextStyle(
          fontSize: 16,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

class _DiscountType extends StatelessWidget {
  final ItemRowDiscountWidget widget;
  final Function callback;
  final DiscountType? type;
  final bool isValid;
  final double? currentValue;

  const _DiscountType(
    this.widget,
    this.callback,
    this.type,
    this.isValid,
    this.currentValue,
  );

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
                onChanged: (DiscountType? value) {
                  callback(value);

                  context.read<ReceiptBloc>().add(
                        ReceiptAddDiscountToProductEvent(
                          index: widget.index,
                          discount: currentValue,
                          type: value!,
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
                onChanged: (DiscountType? value) {
                  callback(value);
                  context.read<ReceiptBloc>().add(
                        ReceiptAddDiscountToProductEvent(
                          index: widget.index,
                          discount: currentValue,
                          type: value!,
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
