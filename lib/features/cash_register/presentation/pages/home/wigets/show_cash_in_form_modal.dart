import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import 'package:check_bloc/features/cash_register/presentation/blocs/shift_bloc/shift_bloc.dart';
import 'package:check_bloc/features/cash_register/presentation/widgets/button_widget.dart';

showCashInFormModal(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return const _CashInForm();
    },
  );
}

class _CashInForm extends StatelessWidget {
  const _CashInForm();

  @override
  Widget build(BuildContext context) {
    String sum = '';

    return AlertDialog(
      title: Text('${AppLocalizations.of(context)?.cashIn}'),
      content: SizedBox(
        height: 140,
        child: Column(
          children: [
            TextField(
              autofocus: true,
              autocorrect: false,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
              ],
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: AppLocalizations.of(context)?.enterAmount,
              ),
              onChanged: (value) {
                sum = value;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ButtonWidget(
              label: '${AppLocalizations.of(context)?.enter}',
              onPressed: () {
                final result = double.tryParse(sum);
                if (result != null && result > 0) {
                  context.pop();
                }
                context.read<ShiftBloc>().add(ShifCashInEvent(result));
              },
            )
          ],
        ),
      ),
    );
  }
}
