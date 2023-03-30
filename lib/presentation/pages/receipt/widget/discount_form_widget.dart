import 'package:check_bloc/presentation/blocs/receipt_bloc/receipt_bloc.dart';
import 'package:check_bloc/presentation/pages/receipt/widget/general_discount.dart';
import 'package:check_bloc/presentation/pages/receipt/widget/item_row_discount_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DiscountFormWidget extends StatelessWidget {
  const DiscountFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: const Text('Вкажіть розмір знижки'),
      content: const SingleChildScrollView(child: DiscountFormBodyWidget()),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(
          onPressed: () {
            context.pop();
          },
          child: const Text(
            'Продовжити',
            style: TextStyle(fontSize: 18),
          ),
        )
      ],
    );
  }
}

class DiscountFormBodyWidget extends StatelessWidget {
  const DiscountFormBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final childern = context.watch<ReceiptBloc>().state.receipt?.goods;
    List<Widget> items = [];
    if (childern != null) {
      for (var item in childern) {
        items.add(ItemRowDiscountWidget(
          item: item,
          index: childern.indexOf(item),
        ));
      }
    }
    return Column(
      children: [
        ...items,
        GeneralDiscount(info: context.read<ReceiptBloc>().state.receipt?.info),
      ],
    );
  }
}
