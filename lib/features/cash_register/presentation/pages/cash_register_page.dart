import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'package:check_bloc/features/cash_register/presentation/blocs/cash_register_bloc/cash_register_bloc.dart';
import 'package:check_bloc/features/cash_register/presentation/blocs/cash_register_form_bloc/cash_register_form_bloc.dart';
import 'package:check_bloc/features/cash_register/presentation/widgets/button_widget.dart';

class CashRegisterPage extends StatelessWidget {
  const CashRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${AppLocalizations.of(context)?.cashRegisterSettings}',
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const _CashRegisterInfo(),
            const SizedBox(
              height: 20,
            ),
            BlocBuilder<CashRegisterFormBloc, CashRegisterFormState>(
              builder: (context, state) {
                return TextField(
                  controller:
                      context.read<CashRegisterFormBloc>().state.controller,
                  decoration: InputDecoration(
                    labelText: '${AppLocalizations.of(context)?.licenseKey}',
                    border: const OutlineInputBorder(),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Flexible(
              child: Row(
                children: [
                  Expanded(
                    child: ButtonWidget(
                      label: '${AppLocalizations.of(context)?.save}',
                      onPressed: () {
                        context
                            .read<CashRegisterFormBloc>()
                            .add(CashRegisterFormSubmitEvent());
                        context
                            .read<CashRegisterBloc>()
                            .add(CashRegisterLoadEvent());
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            insetPadding: const EdgeInsets.all(5),
                            contentPadding: const EdgeInsets.all(2),
                            content: SizedBox(
                              height: 300,
                              width: double.maxFinite,
                              child: MobileScanner(
                                onDetect: (capture) {
                                  final List<Barcode> barcodes =
                                      capture.barcodes;
                                  for (final barcode in barcodes) {
                                    if (barcode.rawValue != null) {
                                      context
                                          .read<CashRegisterFormBloc>()
                                          .state
                                          .controller
                                          .text = barcode.rawValue!;
                                      context.pop();
                                    }
                                  }
                                },
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: const Icon(Icons.qr_code_scanner),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CashRegisterInfo extends StatelessWidget {
  const _CashRegisterInfo();

  @override
  Widget build(BuildContext context) {
    final register = context.watch<CashRegisterBloc>().state.cashRegister;
    return BlocBuilder<CashRegisterBloc, CashRegisterState>(
      builder: (context, state) {
        if (register == null) {
          return Text('${AppLocalizations.of(context)?.addLicenseKey}');
        } else {
          return Column(
            children: [
              Text(
                '${AppLocalizations.of(context)?.cashRegister}:',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(register.fiscalNumber),
              const SizedBox(
                height: 5,
              ),
              Text('${register.address}'),
            ],
          );
        }
      },
    );
  }
}
