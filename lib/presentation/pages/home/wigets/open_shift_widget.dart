import 'package:check_bloc/presentation/pages/home/wigets/show_register_shift_action_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OpenShiftWidget extends StatelessWidget {
  const OpenShiftWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      label: Text('${AppLocalizations.of(context)?.opened}'),
      labelStyle: const TextStyle(color: Colors.white, fontSize: 12),
      backgroundColor: Colors.green.shade400,
      visualDensity: const VisualDensity(horizontal: 0.0, vertical: -4),
      elevation: 0,
      onPressed: () {
        showRegisterShiftActionModal(context);
      },
    );
  }
}
