import 'package:check_bloc/config/constants.dart';
import 'package:check_bloc/presentation/blocs/receipt_delivery_bloc/receipt_delivery_bloc.dart';
import 'package:check_bloc/presentation/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

showSendEmailFormModal({
  required BuildContext context,
  required String receiptid,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return _EmailSendForm(context, receiptid);
    },
  );
}

class _EmailSendForm extends StatelessWidget {
  final BuildContext context;
  final String receiptId;
  const _EmailSendForm(this.context, this.receiptId);

  @override
  Widget build(BuildContext context) {
    String email = '';
    context.read<ReceiptDeliveryBloc>().add(
          ReceiptDeliveryInitialEvent(),
        );
    return AlertDialog(
      title: const Text('Відправити на e-mail'),
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
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Вкажіть e-email',
                    ),
                  ),
                  const SizedBox(height: 10),
                  ButtonWidget(
                    onPressed: () {
                      if (email.isNotEmpty) {
                        context.read<ReceiptDeliveryBloc>().add(
                              ReceiptDeliverySendEmailEvent(receiptId, email),
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
