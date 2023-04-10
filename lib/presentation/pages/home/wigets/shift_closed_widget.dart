import 'package:check_bloc/config/constants.dart';
import 'package:check_bloc/presentation/blocs/cash_register_bloc/cash_register_bloc.dart';
import 'package:check_bloc/presentation/pages/home/wigets/show_empty_register_key_modal.dart';
import 'package:check_bloc/presentation/pages/home/wigets/show_open_shift_action_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShiftClosedWidget extends StatelessWidget {
  const ShiftClosedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CashRegisterBloc, CashRegisterState>(
      builder: (context, state) {
        if (state.status == BlocStateStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return ActionChip(
          label: Text('${AppLocalizations.of(context)?.closed}'),
          labelStyle: const TextStyle(color: Colors.white, fontSize: 12),
          backgroundColor: Colors.red.shade400,
          visualDensity: const VisualDensity(horizontal: 0.0, vertical: -4),
          elevation: 0,
          onPressed: () {
            if (state.cashRegister == null) {
              showEmptyRegisterKeyModal(context);
            } else {
              showOpenShiftActionModal(context, state.cashRegister);
            }
          },
        );
      },
    );
  }
}
