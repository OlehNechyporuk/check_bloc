import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_bloc/core/extesions.dart';
import 'package:check_bloc/features/cash_register/domain/entity/receipt_item_entity.dart';
import 'package:check_bloc/features/cash_register/presentation/blocs/receipt_bloc/receipt_bloc.dart';

class ItemRowWidget extends StatefulWidget {
  final ReceiptItemEntity item;
  final int index;
  final TextEditingController controller;

  const ItemRowWidget({
    super.key,
    required this.item,
    required this.index,
    required this.controller,
  });

  @override
  State<ItemRowWidget> createState() => ItemRowWidgetState();
}

class ItemRowWidgetState extends State<ItemRowWidget> {
  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Title(title: widget.item.good.name),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _QualityControls(widget: widget),
            _PriceWidget(widget: widget),
            IconButton(
              onPressed: () {
                context
                    .read<ReceiptBloc>()
                    .add(ReceiptDeleteItemEvent(widget.index));
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.black38,
              ),
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

class _QualityControls extends StatelessWidget {
  final ItemRowWidget? widget;
  const _QualityControls({this.widget});

  @override
  Widget build(BuildContext context) {
    widget?.controller.text =
        '${context.read<ReceiptBloc>().state.receipt.goods[widget!.index].quantity}';
    widget?.controller.selection =
        TextSelection.collapsed(offset: widget!.controller.text.length);
    return SizedBox(
      width: 140,
      height: 30,
      child: TextField(
        controller: widget?.controller,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: const OutlineInputBorder(),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          prefixIcon: InkWell(
            onTap: () {
              context.read<ReceiptBloc>().add(
                    ReceiptUpdateQuantityEvent(
                      quantity: -1,
                      index: widget?.index,
                    ),
                  );
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: const Icon(
              Icons.remove,
              color: Colors.black38,
            ),
          ),
          suffixIcon: InkWell(
            onTap: () {
              context.read<ReceiptBloc>().add(
                    ReceiptUpdateQuantityEvent(
                      quantity: 1,
                      index: widget?.index,
                    ),
                  );
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: const Icon(
              Icons.add,
              color: Colors.black38,
            ),
          ),
        ),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        onChanged: (value) {
          context.read<ReceiptBloc>().add(
                ReceiptUpdateQuantityEvent(
                  quantity: int.tryParse(value),
                  index: widget?.index,
                ),
              );
        },
      ),
    );
  }
}

class _PriceWidget extends StatelessWidget {
  final ItemRowWidget widget;
  const _PriceWidget({required this.widget});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'x ${widget.item.good.price.toUAH()} ₴',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
        BlocBuilder<ReceiptBloc, ReceiptState>(
          builder: (context, state) {
            return const Text(
              '',
              // '${widget.item.total.toUAH()} ₴',
              style: TextStyle(fontSize: 15),
            );
          },
        ),
        const _Discount()
      ],
    );
  }
}

class _Discount extends StatelessWidget {
  const _Discount();

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
