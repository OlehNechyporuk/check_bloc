import 'package:check_bloc/presentation/pages/receipt/widget/receipt_form_widget.dart';
import 'package:check_bloc/presentation/pages/receipt/widget/receipt_items_widget.dart';
import 'package:flutter/material.dart';

class ReceiptAddPage extends StatelessWidget {
  const ReceiptAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Чек',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              ReceiptItemsWidget(),
              SizedBox(
                height: 20,
              ),
              ReceiptFormWidget(),
            ],
          ),
        ));
  }
}
