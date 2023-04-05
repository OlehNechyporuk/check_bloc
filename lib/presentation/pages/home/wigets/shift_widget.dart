import 'package:check_bloc/config/constants.dart';
import 'package:check_bloc/config/main_navigation_name.dart';
import 'package:check_bloc/domain/entity/cash_register.dart';
import 'package:check_bloc/main.dart';
import 'package:check_bloc/presentation/blocs/cash_register_bloc/cash_register_bloc.dart';
import 'package:check_bloc/presentation/blocs/shift_bloc/shift_bloc.dart';
import 'package:check_bloc/presentation/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ShiftWidget extends StatelessWidget {
  const ShiftWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Text('Зміна'),
            const SizedBox(
              width: 10,
            ),
            BlocListener<ShiftBloc, ShiftState>(
              listener: (context, state) {
                if (state.status == BlocStateStatus.failure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${state.errorText}')),
                  );
                }
              },
              child: BlocBuilder<ShiftBloc, ShiftState>(
                builder: (context, state) {
                  if (state.shift == null) {
                    return const _ShiftClosed();
                  } else {
                    return const _OpenShift();
                  }
                },
              ),
            ),
            const SizedBox(),
          ],
        ),
        const _ShiftOpeningTime(),
      ],
    );
  }
}

class _ShiftClosed extends StatelessWidget {
  const _ShiftClosed();

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
          label: const Text('Закрита'),
          labelStyle: const TextStyle(color: Colors.white, fontSize: 12),
          backgroundColor: Colors.red.shade400,
          visualDensity: const VisualDensity(horizontal: 0.0, vertical: -4),
          elevation: 0,
          onPressed: () {
            if (state.cashRegister == null) {
              _showEmptyRegisterKey(context);
            } else {
              _showOpenShiftAction(context, state.cashRegister);
            }
          },
        );
      },
    );
  }
}

class _ShiftOpeningTime extends StatelessWidget {
  const _ShiftOpeningTime();

  @override
  Widget build(BuildContext context) {
    var formatter = DateFormat.yMd('uk').add_Hm();

    return BlocBuilder<ShiftBloc, ShiftState>(
      builder: (context, state) {
        if (state.shift == null) {
          return const SizedBox();
        } else {
          var t = state.shift?.openedAt ?? DateTime.now();

          return Text(formatter.format(t.toLocal()));
        }
      },
    );
  }
}

class _OpenShift extends StatelessWidget {
  const _OpenShift();

  @override
  Widget build(BuildContext context) {
    final register = context.watch<CashRegisterBloc>().state.cashRegister;
    return ActionChip(
      label: const Text('Відкрита'),
      labelStyle: const TextStyle(color: Colors.white, fontSize: 12),
      backgroundColor: Colors.green.shade400,
      visualDensity: const VisualDensity(horizontal: 0.0, vertical: -4),
      elevation: 0,
      onPressed: () {
        _showRegisterShiftAction(context, register);
      },
    );
  }
}

_showEmptyRegisterKey(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Вкажіть ключ ліцензії'),
        actionsAlignment: MainAxisAlignment.center,
        content:
            const Text('Для відкриття зміни потібно вказати ключ від каси'),
        actions: [
          ElevatedButton(
            onPressed: () {
              context.pop();
              context.pushNamed(MainNavigationName.cashRegisterPage);
            },
            child: const Text('Вказати'),
          )
        ],
      );
    },
  );
}

_showOpenShiftAction(BuildContext context, CashRegister? register) {
  if (register == null) return;

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Каса: ${register.fiscalNumber}'),
        content: Text(register.address ?? ''),
        actions: [
          ButtonWidget(
            label: 'Відкрити зміну',
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

_showRegisterShiftAction(BuildContext context, CashRegister? register) {
  final name = register?.fiscalNumber ?? '';
  final address = register?.address ?? '';
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Каса: $name'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              Text(address),
              const Divider(),
              ElevatedButton.icon(
                onPressed: () {
                  context.pop();
                  showCashInForm(context);
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
                label: const Text(
                  'Внести готівку',
                  style: TextStyle(fontSize: 18),
                ),
                icon: const Icon(Icons.arrow_upward_outlined),
              ),
              const SizedBox(
                height: 10,
              ),
              OutlinedButton.icon(
                onPressed: () {
                  context.pop();
                  showCasOutForm(context);
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
                label: const Text(
                  'Видати готівку',
                  style: TextStyle(fontSize: 18),
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
                child: const Text(
                  'X-звіт',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              OutlinedButton(
                onPressed: () {
                  context.pop();
                  _showAlertCloseDialog(context);
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
                child: const Text(
                  'Закрити зміну',
                  style: TextStyle(color: Colors.red, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

_showAlertCloseDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      final balance =
          context.read<ShiftBloc>().state.shift?.balance?.balance.toDouble();
      return AlertDialog(
        titleTextStyle: const TextStyle(
          fontSize: 18,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        title: const Text('Підтвердження закриття зміни'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Ви дійсно бажаєте закрити зміну?'),
            if (balance != null && balance > 0)
              Text('Ви маєте залишок на\nбалансі: ${balance.toUAH()} грн.'),
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
            child: const Text('Підтвердити'),
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
            child: const Text(
              'Відхилити',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
        ],
      );
    },
  );
}

showCashInForm(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return const CashInForm();
    },
  );
}

class CashInForm extends StatelessWidget {
  const CashInForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String sum = '';

    return AlertDialog(
      title: const Text('Внести готівку'),
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
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Введіть суму',
              ),
              onChanged: (value) {
                sum = value;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ButtonWidget(
              label: 'Внести',
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

showCasOutForm(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return const CashOutForm();
    },
  );
}

class CashOutForm extends StatelessWidget {
  const CashOutForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String sum = '';
    return AlertDialog(
      title: const Text('Видати готівку'),
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
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Введіть суму',
              ),
              onChanged: (value) {
                sum = value;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ButtonWidget(
              label: 'Видати',
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
