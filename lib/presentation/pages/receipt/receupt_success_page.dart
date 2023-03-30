import 'package:check_bloc/config/main_navigation_name.dart';
import 'package:check_bloc/presentation/blocs/receipt_bloc/receipt_bloc.dart';
import 'package:check_bloc/presentation/widgets/receipt_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ReceiptSuccessPage extends StatelessWidget {
  const ReceiptSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    final id = context.watch<ReceiptBloc>().state.receipt?.id;

    if (id != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showReceiptModal(context: context, id: id);
      });
    }

    return Scaffold(
      body: Container(),
    );
  }
}
