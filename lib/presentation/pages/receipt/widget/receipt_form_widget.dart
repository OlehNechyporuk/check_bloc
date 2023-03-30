import 'package:check_bloc/presentation/pages/receipt/widget/service_payments_widget.dart';
import 'package:flutter/material.dart';

class ReceiptFormWidget extends StatelessWidget {
  const ReceiptFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: const [
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              'Тип оплати: ',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ServicePaymentsWidget(),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
