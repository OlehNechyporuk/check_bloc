import 'package:check_bloc/presentation/blocs/shift_bloc/shift_bloc.dart';
import 'package:check_bloc/presentation/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

showCasOutFormModal(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return const _CashOutForm();
    },
  );
}

class _CashOutForm extends StatelessWidget {
  const _CashOutForm();

  @override
  Widget build(BuildContext context) {
    String sum = '';
    return AlertDialog(
      title: Text('${AppLocalizations.of(context)?.cashOut}'),
      content: SizedBox(
        height: 140,
        child: Column(
          children: [
            TextField(
              autofocus: true,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
              ],
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: '${AppLocalizations.of(context)?.enterAmount}',
              ),
              onChanged: (value) {
                sum = value;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ButtonWidget(
              label: '${AppLocalizations.of(context)?.issue}',
              onPressed: () {
                final result = double.tryParse(sum);
                if (result != null && result > 0) {
                  context.pop();
                }
                context.read<ShiftBloc>().add(ShifCashOutEvent(result));
              },
            )
          ],
        ),
      ),
    );
  }
}
