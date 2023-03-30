import 'package:check_bloc/presentation/pages/home/wigets/balance_widget.dart';
import 'package:check_bloc/presentation/pages/home/wigets/shift_widget.dart';
import 'package:flutter/material.dart';

class HeaderWiget extends StatelessWidget {
  const HeaderWiget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          BalanceWidget(),
          ShiftWidget(),
        ],
      ),
    );
  }
}
