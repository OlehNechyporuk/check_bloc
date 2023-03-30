import 'package:check_bloc/config/main_navigation_name.dart';
import 'package:check_bloc/main.dart';
import 'package:check_bloc/presentation/blocs/receipt_bloc/receipt_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ReceiptWidget extends StatelessWidget {
  const ReceiptWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final receipt = context.watch<ReceiptBloc>().state.receipt;
    return receipt == null
        ? const SizedBox()
        : BlocBuilder<ReceiptBloc, ReceiptState>(
            builder: (context, state) {
              return receipt.info['sum']! == 0
                  ? const SizedBox()
                  : ElevatedButton(
                      onPressed: () {
                        context.pushNamed(MainNavigationName.receiptAddPage);
                      },
                      style: const ButtonStyle(
                        padding: MaterialStatePropertyAll(
                          EdgeInsets.symmetric(vertical: 20, horizontal: 60),
                        ),
                        backgroundColor: MaterialStatePropertyAll(Colors.black),
                      ),
                      child: Text(
                        '${receipt.info['sum']?.toUAH()} ₴ ${receipt.info['total']?.toInt().toString()} од.',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    );
            },
          );
  }
}