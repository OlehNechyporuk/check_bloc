import 'package:check_bloc/presentation/blocs/cash_register_bloc/cash_register_bloc.dart';
import 'package:check_bloc/presentation/blocs/cash_register_form_bloc/cash_register_form_bloc.dart';
import 'package:check_bloc/presentation/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CashRegisterPage extends StatelessWidget {
  const CashRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Налаштування каси',
          style: TextStyle(color: Colors.black),
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
                  decoration: const InputDecoration(
                    labelText: 'Ключ ліцензії',
                    border: OutlineInputBorder(),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ButtonWidget(
              label: 'Зберегти',
              onPressed: () {
                context
                    .read<CashRegisterFormBloc>()
                    .add(CashRegisterFormSubmitEvent());
                context.read<CashRegisterBloc>().add(CashRegisterLoadEvent());
              },
            )
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
          return const Text('Додайте ключ ліцензії каси');
        } else {
          return Column(
            children: [
              const Text(
                'Каса:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(register.fiscalNumber ?? ''),
              const SizedBox(
                height: 5,
              ),
              Text(register.address ?? ''),
            ],
          );
        }
      },
    );
  }
}
