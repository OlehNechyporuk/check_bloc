import 'package:check_bloc/core/extesions.dart';
import 'package:check_bloc/presentation/blocs/shift_bloc/shift_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

showCloseShiftModal(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      final balance =
          context.read<ShiftBloc>().state.shift?.balance.balance.toDouble();
      return AlertDialog(
        titleTextStyle: const TextStyle(
          fontSize: 18,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        title:
            Text('${AppLocalizations.of(context)?.confirmationClosingShift}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('${AppLocalizations.of(context)?.areSureCloseShift}'),
            if (balance != null && balance > 0)
              Text(
                '${AppLocalizations.of(context)?.youHaveBalance}: ${balance.toUAH()} ${AppLocalizations.of(context)?.uah}',
              ),
          ],
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          ElevatedButton(
            onPressed: () {
              context.pop();
              context.read<ShiftBloc>().add((ShifCloseEvent()));
            },
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                Colors.green,
              ),
            ),
            child: Text('${AppLocalizations.of(context)?.confirm}'),
          ),
          OutlinedButton(
            onPressed: () {
              context.pop();
            },
            style: const ButtonStyle(
              side: MaterialStatePropertyAll(
                BorderSide(
                  color: Colors.red,
                ),
              ),
            ),
            child: Text(
              '${AppLocalizations.of(context)?.reject}',
              style: const TextStyle(
                color: Colors.red,
              ),
            ),
          ),
        ],
      );
    },
  );
}
