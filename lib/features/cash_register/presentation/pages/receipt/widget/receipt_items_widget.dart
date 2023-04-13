import 'package:flutter/material.dart';

import 'package:check_bloc/features/cash_register/presentation/pages/receipt/widget/list_widget.dart';
import 'package:check_bloc/features/cash_register/presentation/pages/receipt/widget/receipt_result_widget.dart';

class ReceiptItemsWidget extends StatelessWidget {
  const ReceiptItemsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      decoration: BoxDecoration(color: Colors.grey.shade100),
      child: Column(
        children: const [
          Text(
            '* * * * * * * * * * * * * * * * * * *',
            style: TextStyle(fontSize: 18),
          ),
          ListWidget(),
          Text(
            '* * * * * * * * * * * * * * * * * * *',
            style: TextStyle(fontSize: 18),
          ),
          ReceiptResultWidget(),
        ],
      ),
    );
  }
}
