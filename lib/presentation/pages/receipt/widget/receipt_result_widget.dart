import 'package:check_bloc/data/checkbox/repository/payment_repository_impl.dart';
import 'package:check_bloc/main.dart';
import 'package:check_bloc/presentation/blocs/receipt_bloc/receipt_bloc.dart';
import 'package:check_bloc/presentation/pages/receipt/widget/discount_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReceiptResultWidget extends StatelessWidget {
  const ReceiptResultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const DiscountFormWidget(),
              );
            },
            child: const Text(
              'Додати знижку',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
        const SizedBox(height: 10),
        const TotalSumWidget(),
      ],
    );
  }
}

class TotalSumWidget extends StatelessWidget {
  const TotalSumWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReceiptBloc, ReceiptState>(
      builder: (context, state) {
        final total = state.receipt;
        final payment = state.receipt?.payments?.first;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Сума разом:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${total?.info['sum']?.toUAH()} ₴',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (total?.info['sum'] != 0)
                  IconButton(
                    onPressed: () {
                      context.read<ReceiptBloc>().add(ReceiptClearItemsEvent());
                    },
                    icon: const Icon(Icons.delete),
                    color: Colors.black38,
                  )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'До сплати:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            if (total?.info['discount'] != 0)
              Text(
                'Знижка: ${total?.info['discount']?.toUAH()}',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            const SizedBox(
              height: 5,
            ),
            Text(
              payment?.convertStringToEnum == PaymentType.cash
                  ? '${total?.info['paid']?.toRoundedUAH()} ₴'
                  : '${total?.info['paid']?.toUAH()} ₴',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        );
      },
    );
  }
}
