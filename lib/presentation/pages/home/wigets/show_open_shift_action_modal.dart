import 'package:check_bloc/domain/entity/cash_register.dart';
import 'package:check_bloc/presentation/blocs/shift_bloc/shift_bloc.dart';
import 'package:check_bloc/presentation/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

showOpenShiftActionModal(BuildContext context, CashRegister? register) {
  if (register == null) return;

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          '${AppLocalizations.of(context)?.cashRegister}: ${register.fiscalNumber}',
        ),
        content: Text(register.address ?? ''),
        actions: [
          ButtonWidget(
            label: '${AppLocalizations.of(context)?.openShift}',
            onPressed: () {
              context.pop();
              context.read<ShiftBloc>().add(ShiftOpenEvent());
            },
          ),
        ],
      );
    },
  );
}
