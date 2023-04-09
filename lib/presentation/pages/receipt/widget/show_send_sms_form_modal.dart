import 'package:check_bloc/config/constants.dart';
import 'package:check_bloc/presentation/blocs/receipt_delivery_bloc/receipt_delivery_bloc.dart';
import 'package:check_bloc/presentation/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

showSendSmsFormModal({
  required BuildContext context,
  required String receiptid,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return _SmsSendForm(context, receiptid);
    },
  );
}

class _SmsSendForm extends StatelessWidget {
  final BuildContext context;
  final String receiptId;
  const _SmsSendForm(this.context, this.receiptId);

  @override
  Widget build(BuildContext context) {
    String phone = '';
    context.read<ReceiptDeliveryBloc>().add(
          ReceiptDeliveryInitialEvent(),
        );
    return AlertDialog(
      title: const Text('Відправити sms'),
      content: BlocListener<ReceiptDeliveryBloc, ReceiptDeliveryState>(
        listener: (context, state) {
          if (state.status == BlocStateStatus.failure) {
            if (state.errorText != null) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('${state.errorText}')));
            }
          }
        },
        child: BlocBuilder<ReceiptDeliveryBloc, ReceiptDeliveryState>(
          builder: (context, state) {
            if (state.status == BlocStateStatus.loading) {
              return const SizedBox(
                height: 100,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state.status == BlocStateStatus.success) {
              return SizedBox(
                height: 50,
                child: Center(
                  child: Row(
                    children: const [
                      Icon(
                        Icons.send,
                        color: Colors.green,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Відправлено',
                        style: TextStyle(color: Colors.green),
                      )
                    ],
                  ),
                ),
              );
            } else {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    keyboardType: TextInputType.phone,
                    autocorrect: false,
                    onChanged: (value) {
                      phone = value;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Вкажіть телефон',
                    ),
                  ),
                  const SizedBox(height: 10),
                  ButtonWidget(
                    onPressed: () {
                      if (phone.isNotEmpty) {
                        context.read<ReceiptDeliveryBloc>().add(
                              ReceiptDeliverySendSmsEvent(receiptId, phone),
                            );
                      }
                    },
                    label: 'Відправити',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
