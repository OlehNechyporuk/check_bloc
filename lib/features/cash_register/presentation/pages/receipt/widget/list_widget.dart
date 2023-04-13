import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_bloc/features/cash_register/presentation/blocs/receipt_bloc/receipt_bloc.dart';
import 'package:check_bloc/features/cash_register/presentation/pages/receipt/widget/item_row_widget.dart';

class ListWidget extends StatelessWidget {
  const ListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final childern = context.watch<ReceiptBloc>().state.receipt.goods;
    List<Widget> items = [];
    if (childern.isEmpty) {
      for (var item in childern) {
        items.add(
          ItemRowWidget(
            item: item,
            index: childern.indexOf(item),
            controller: TextEditingController(),
          ),
        );
      }
    }
    return Column(
      children: [...items],
    );
  }
}
