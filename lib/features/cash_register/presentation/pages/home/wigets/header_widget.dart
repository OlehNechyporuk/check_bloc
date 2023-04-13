import 'package:flutter/material.dart';

import 'package:check_bloc/features/cash_register/presentation/pages/home/wigets/balance_widget.dart';
import 'package:check_bloc/features/cash_register/presentation/pages/home/wigets/shift_widget.dart';

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
