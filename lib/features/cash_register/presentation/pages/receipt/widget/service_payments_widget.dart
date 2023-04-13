import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_bloc/config/constants.dart';
import 'package:check_bloc/core/extesions.dart';
import 'package:check_bloc/features/cash_register/data/checkbox/repository/payment_repository_impl.dart';
import 'package:check_bloc/features/cash_register/presentation/blocs/receipt_bloc/receipt_bloc.dart';
import 'package:check_bloc/features/cash_register/presentation/blocs/shift_bloc/shift_bloc.dart';
import 'package:check_bloc/features/cash_register/presentation/widgets/receipt_modal.dart';

class ServicePaymentsWidget extends StatefulWidget {
  const ServicePaymentsWidget({super.key});

  @override
  State<ServicePaymentsWidget> createState() => _ServicePaymentsWidgetState();
}

class _ServicePaymentsWidgetState extends State<ServicePaymentsWidget> {
  PaymentType current = PaymentType.cash;
  double? getCash;

  updateCashSum(double? cash) {
    setState(() {
      if (cash == null) {
        getCash = null;
      } else {
        getCash = cash * 100;
      }
    });
  }

  bool isValid(double total) {
    if (current == PaymentType.card) {
      return true;
    } else if (current == PaymentType.cash) {
      final cash = currentCash;

      if (cash == null) {
        return false;
      }

      if ((cash) >= total) {
        return true;
      }

      return false;
    }

    return false;
  }

  double? get currentCash {
    return getCash;
  }

  updateCurrentButton(PaymentType type) {
    setState(() {
      current = type;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReceiptBloc, ReceiptState>(
      listener: (context, state) {
        if (state.status == BlocStateStatus.failure) {
          if (state.errorText != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.errorText}'),
              ),
            );
          }
        }
      },
      child: BlocBuilder<ReceiptBloc, ReceiptState>(
        builder: (context, state) {
          if (state.lastReceiptId != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              final id = state.lastReceiptId;
              if (id != null) {
                showReceiptModal(context: context, id: id, goHome: true);

                context.read<ShiftBloc>().add(ShiftCurrentEvent());
              }
            });
          }

          // current = state.receipt?.payments?.first.convertStringToEnum ??
          //     PaymentType.cash;

          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _CashPaymentButton(current, updateCurrentButton),
                  _CardPaymentButton(current, updateCurrentButton),
                  _OtherPaymentButton(current, updateCurrentButton),
                ],
              ),
              const SizedBox(height: 20),
              if (current == PaymentType.cash)
                _CashInputWidget(
                  updateCashSum: updateCashSum,
                  currentCash: currentCash,
                  isValid: isValid,
                ),
              const SizedBox(height: 20),
              // SizedBox(
              //   width: double.maxFinite,
              //   child: state.status == BlocStateStatus.loading
              //       ? const Center(child: CircularProgressIndicator())
              //       : ElevatedButton(
              //           onPressed: isValid(state.receipt?.info['paid'] ?? 0)
              //               ? () {
              //                   context
              //                       .read<ReceiptBloc>()
              //                       .add(ReceiptAddEvent());
              //                 }
              //               : null,
              //           style: ElevatedButton.styleFrom(
              //             backgroundColor: Colors.black,
              //             disabledBackgroundColor: Colors.grey,
              //             padding: const EdgeInsets.symmetric(vertical: 20),
              //           ),
              //           child: const Text(
              //             'Видати чек',
              //             style: TextStyle(fontSize: 22, color: Colors.white),
              //           ),
              //         ),
              // ),
            ],
          );
        },
      ),
    );
  }
}

class _CashPaymentButton extends StatelessWidget {
  final PaymentType active;
  final Function updateType;
  const _CashPaymentButton(this.active, this.updateType);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        updateType(PaymentType.cash);
        context
            .read<ReceiptBloc>()
            .add(const ReceiptChangePaymentEvent('CASH', null));
      },
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: Container(
        decoration: active == PaymentType.cash
            ? BoxDecoration(
                border: Border.all(width: 1, color: Colors.black),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              )
            : const BoxDecoration(),
        width: 100,
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text(
              'Готівка',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Icon(
              Icons.payments,
              size: 30,
            )
          ],
        ),
      ),
    );
  }
}

class _CardPaymentButton extends StatelessWidget {
  final PaymentType active;
  final Function updateType;
  const _CardPaymentButton(this.active, this.updateType);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        updateType(PaymentType.card);
        context
            .read<ReceiptBloc>()
            .add(const ReceiptChangePaymentEvent('CARD', null));
      },
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: Container(
        decoration: active == PaymentType.card
            ? BoxDecoration(
                border: Border.all(width: 1, color: Colors.black),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              )
            : const BoxDecoration(),
        width: 100,
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text(
              'Карта',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 4,
            ),
            Icon(
              Icons.credit_card,
              size: 30,
            )
          ],
        ),
      ),
    );
  }
}

class _OtherPaymentButton extends StatelessWidget {
  final PaymentType active;
  final Function updateType;
  const _OtherPaymentButton(this.active, this.updateType);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        updateType(PaymentType.cashless);
        context
            .read<ReceiptBloc>()
            .add(const ReceiptChangePaymentEvent('CASHLESS', null));
      },
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: Container(
        decoration: active == PaymentType.cashless
            ? BoxDecoration(
                border: Border.all(width: 1, color: Colors.black),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              )
            : const BoxDecoration(),
        width: 100,
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text(
              'Інше',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 4,
            ),
            Icon(
              Icons.settings,
              size: 30,
            )
          ],
        ),
      ),
    );
  }
}

class _CashInputWidget extends StatelessWidget {
  final Function updateCashSum;
  final double? currentCash;
  final Function isValid;
  const _CashInputWidget({
    required this.updateCashSum,
    required this.currentCash,
    required this.isValid,
  });

  @override
  Widget build(BuildContext context) {
    // final total = context.read<ReceiptBloc>().state.receipt?.info['paid'] ?? 0;
    final balance = context.read<ShiftBloc>().state.shift?.balance.balance ?? 0;
    const total = 0;

    return Column(
      children: [
        SizedBox(
          height: 50,
          child: TextFormField(
            initialValue: currentCash?.toDouble().toUAH(),
            onChanged: (value) {
              final getCash = double.tryParse(value);
              updateCashSum(getCash);
              context
                  .read<ReceiptBloc>()
                  .add(ReceiptChangePaymentEvent('CASH', int.tryParse(value)));
            },
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: 'Отримано готівки',
              errorText: isValid(total) ? null : '',
              errorStyle: const TextStyle(
                height: 0,
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
        if (currentCash != null && currentCash! > 0)
          const SizedBox(
            height: 10,
          ),
        if (currentCash != null && currentCash! >= total)
          // Text(
          //   'Решта: ${(total - (currentCash ?? 0)).abs().toRoundedUAH()} ₴',
          //   style: const TextStyle(fontSize: 17),
          // ),
          if (currentCash != null && (total - currentCash!).abs() > balance)
            Text(
              'Недостатньо готівки, баланс: ${balance.toDouble().toUAH()} ₴',
              style: const TextStyle(color: Colors.red),
            ),
      ],
    );
  }
}
