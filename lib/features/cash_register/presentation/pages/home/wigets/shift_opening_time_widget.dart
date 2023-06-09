import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_bloc/core/extesions.dart';
import 'package:check_bloc/features/cash_register/presentation/blocs/shift_bloc/shift_bloc.dart';

class ShiftOpeningTimeWidget extends StatelessWidget {
  const ShiftOpeningTimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShiftBloc, ShiftState>(
      builder: (context, state) {
        if (state.shift == null) {
          return const SizedBox();
        } else {
          final shiftOpeingTime = state.shift?.openedAt ?? DateTime.now();
          return Text(shiftOpeingTime.toLocalTime());
        }
      },
    );
  }
}
