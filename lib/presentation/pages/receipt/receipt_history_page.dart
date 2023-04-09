import 'package:check_bloc/config/constants.dart';
import 'package:check_bloc/domain/entity/receipt.dart';
import 'package:check_bloc/main.dart';
import 'package:check_bloc/presentation/blocs/cashier_bloc/cashier_bloc.dart';
import 'package:check_bloc/presentation/blocs/receipts_history_bloc/receipts_history_bloc.dart';
import 'package:check_bloc/presentation/pages/receipt/widget/show_send_email_form_modal.dart';
import 'package:check_bloc/presentation/pages/receipt/widget/show_send_sms_form_modal.dart';
import 'package:check_bloc/presentation/widgets/receipt_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReceiptHistoryPage extends StatelessWidget {
  const ReceiptHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Історія чеків',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: const ReceiptsListWiget(),
    );
  }
}

class ReceiptsListWiget extends StatelessWidget {
  const ReceiptsListWiget({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ReceiptsHistoryBloc>().add(ReceiptsHistoryLoadedEvent());

    return BlocBuilder<ReceiptsHistoryBloc, ReceiptsHistoryState>(
      builder: (context, state) {
        if (state.status == BlocStateStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.status == BlocStateStatus.success) {
          return ListView.separated(
            itemCount: state.receipts?.length ?? 0,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) =>
                ReceiptRowWidget(receipt: state.receipts?[index]),
          );
        }
        return const SizedBox();
      },
    );
  }
}

class ReceiptRowWidget extends StatelessWidget {
  final Receipt? receipt;
  const ReceiptRowWidget({super.key, this.receipt});

  @override
  Widget build(BuildContext context) {
    final fiscalCode = receipt?.fiscalCode == null
        ? ''
        : 'Фіскальний номер: ${receipt?.fiscalCode}\n';
    return ListTile(
      title: Text(
        '${receipt?.typeConvert} (${receipt?.payments?.first.label})  ${receipt?.totalSum?.toDouble().toUAH()} ₴',
      ),
      subtitle: Text(
        '$fiscalCodeНомер зміни ${receipt?.shift?.serial}\nДата/час: ${receipt?.createdAt?.toLocalTime()}',
      ),
      trailing: PopupMenuButton(
        elevation: 4,
        padding: EdgeInsets.zero,
        icon: const Icon(Icons.more_vert_outlined),
        itemBuilder: (BuildContext context) => [
          PopupMenuItem(
            onTap: () {
              final id = receipt?.id;
              if (id != null) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showReceiptModal(context: context, id: id);
                });
              }
            },
            child: Row(
              children: const [
                Icon(Icons.visibility),
                SizedBox(width: 10),
                Text('Переглянути чек')
              ],
            ),
          ),
          PopupMenuItem(
            onTap: () {
              final id = receipt?.id;
              if (id != null) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showSendEmailFormModal(context: context, receiptid: id);
                });
              }
            },
            child: Row(
              children: const [
                Icon(Icons.send),
                SizedBox(width: 10),
                Text('Відправити на email')
              ],
            ),
          ),
          if (context
                  .read<CashierBloc>()
                  .state
                  .cashier
                  ?.organization
                  ?.canSendSms ==
              true)
            PopupMenuItem(
              onTap: () {
                final id = receipt?.id;
                if (id != null) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    showSendSmsFormModal(context: context, receiptid: id);
                  });
                }
              },
              child: Row(
                children: const [
                  Icon(Icons.sms_sharp),
                  SizedBox(width: 10),
                  Text('Відправити на sms')
                ],
              ),
            ),
          PopupMenuItem(
            onTap: () {},
            child: Row(
              children: const [
                Icon(Icons.arrow_circle_left_outlined),
                SizedBox(width: 10),
                Text('Повернути')
              ],
            ),
          ),
        ],
      ),
    );
  }
}
