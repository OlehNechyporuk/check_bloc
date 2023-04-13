import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:check_bloc/features/cash_register/presentation/pages/receipt/widget/receipt_form_widget.dart';
import 'package:check_bloc/features/cash_register/presentation/pages/receipt/widget/receipt_items_widget.dart';

class ReceiptAddPage extends StatelessWidget {
  const ReceiptAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${AppLocalizations.of(context)?.receipt}',
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            ReceiptItemsWidget(),
            SizedBox(
              height: 20,
            ),
            ReceiptFormWidget(),
          ],
        ),
      ),
    );
  }
}
