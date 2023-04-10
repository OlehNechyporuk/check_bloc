import 'package:check_bloc/presentation/blocs/cash_register_bloc/cash_register_bloc.dart';
import 'package:check_bloc/presentation/pages/home/wigets/show_cash_in_form_modal.dart';
import 'package:check_bloc/presentation/pages/home/wigets/show_cash_out_form_modal.dart';
import 'package:check_bloc/presentation/pages/home/wigets/show_close_shift_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

showRegisterShiftActionModal(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: BlocBuilder<CashRegisterBloc, CashRegisterState>(
          builder: (context, state) {
            return Text(
              '${AppLocalizations.of(context)?.cashRegister}: ${state.cashRegister?.fiscalNumber}',
            );
          },
        ),
        content: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<CashRegisterBloc, CashRegisterState>(
                builder: (context, state) {
                  return Text('${state.cashRegister?.address}');
                },
              ),
              const Divider(),
              ElevatedButton.icon(
                onPressed: () {
                  context.pop();
                  showCashInFormModal(context);
                },
                style: const ButtonStyle(
                  minimumSize:
                      MaterialStatePropertyAll(Size(double.maxFinite, 50)),
                  side: MaterialStatePropertyAll(
                    BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                ),
                label: Text(
                  '${AppLocalizations.of(context)?.cashIn}',
                  style: const TextStyle(fontSize: 18),
                ),
                icon: const Icon(Icons.arrow_upward_outlined),
              ),
              const SizedBox(
                height: 10,
              ),
              OutlinedButton.icon(
                onPressed: () {
                  context.pop();
                  showCasOutFormModal(context);
                },
                style: const ButtonStyle(
                  minimumSize:
                      MaterialStatePropertyAll(Size(double.maxFinite, 50)),
                  side: MaterialStatePropertyAll(
                    BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                ),
                label: Text(
                  '${AppLocalizations.of(context)?.cashOut}',
                  style: const TextStyle(fontSize: 18),
                ),
                icon: const Icon(Icons.arrow_downward_outlined),
              ),
              const Divider(),
              OutlinedButton(
                onPressed: () {},
                style: const ButtonStyle(
                  minimumSize:
                      MaterialStatePropertyAll(Size(double.maxFinite, 50)),
                  side: MaterialStatePropertyAll(
                    BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                ),
                child: Text(
                  '${AppLocalizations.of(context)?.xReport}',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              OutlinedButton(
                onPressed: () {
                  context.pop();
                  showCloseShiftModal(context);
                },
                style: const ButtonStyle(
                  minimumSize:
                      MaterialStatePropertyAll(Size(double.maxFinite, 50)),
                  side: MaterialStatePropertyAll(
                    BorderSide(
                      color: Colors.red,
                    ),
                  ),
                ),
                child: Text(
                  '${AppLocalizations.of(context)?.closeShift}',
                  style: const TextStyle(color: Colors.red, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
