import 'package:check_bloc/main.dart';
import 'package:check_bloc/presentation/blocs/shift_bloc/shift_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BalanceWidget extends StatelessWidget {
  const BalanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Баланс'),
        BlocBuilder<ShiftBloc, ShiftState>(
          builder: (context, state) {
            final balance = context.watch<ShiftBloc>().state.shift?.balance;
            return Text.rich(
              TextSpan(
                text:
                    balance == null ? '0' : balance.balance.toDouble().toUAH(),
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                children: const <TextSpan>[
                  TextSpan(
                    text: ' ₴',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            );
          },
        )
      ],
    );
  }
}
