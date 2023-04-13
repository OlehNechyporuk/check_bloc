import 'package:check_bloc/config/main_navigation_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

showEmptyRegisterKeyModal(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('${AppLocalizations.of(context)?.enterTheLicenseKey}'),
        actionsAlignment: MainAxisAlignment.center,
        content: Text('${AppLocalizations.of(context)?.toOpenShiftHelp}'),
        actions: [
          ElevatedButton(
            onPressed: () {
              context.pop();
              context.pushNamed(CashRegisterNavigationName.cashRegisterPage);
            },
            child: Text('${AppLocalizations.of(context)?.specify}'),
          )
        ],
      );
    },
  );
}
