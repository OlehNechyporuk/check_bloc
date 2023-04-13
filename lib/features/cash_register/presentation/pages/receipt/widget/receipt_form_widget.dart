import 'package:check_bloc/features/cash_register/presentation/pages/receipt/widget/service_payments_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReceiptFormWidget extends StatelessWidget {
  const ReceiptFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              '${AppLocalizations.of(context)?.paymentType}: ',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const ServicePaymentsWidget(),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
