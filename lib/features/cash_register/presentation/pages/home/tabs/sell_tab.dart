import 'package:check_bloc/features/cash_register/presentation/blocs/shift_bloc/shift_bloc.dart';
import 'package:check_bloc/features/cash_register/presentation/widgets/report_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_bloc/config/constants.dart';
import 'package:check_bloc/features/cash_register/presentation/blocs/receipt_bloc/receipt_bloc.dart';
import 'package:check_bloc/features/cash_register/presentation/pages/home/wigets/products_widget.dart';
import 'package:check_bloc/features/cash_register/presentation/pages/home/wigets/receipt_widget.dart';
import 'package:check_bloc/features/cash_register/presentation/pages/home/wigets/search_product_widget.dart';

class SellTab extends StatelessWidget {
  const SellTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocListener<ReceiptBloc, ReceiptState>(
        listener: (context, state) {
          if (state.status == BlocStateStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red.shade300,
                content: Text('${state.errorText}'),
              ),
            );
          }
        },
        child: Column(
          children: const [
            SearchProductWiget(),
            SizedBox(height: 5),
            Expanded(flex: 1, child: ProductsWidget()),
            ReceiptWidget(),
            SizedBox(height: 10),
            CheckZreportModalWidget(),
          ],
        ),
      ),
    );
  }
}

class CheckZreportModalWidget extends StatelessWidget {
  const CheckZreportModalWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShiftBloc, ShiftState>(
      builder: (context, state) {
        if (state.status == BlocStateStatus.success) {
          if (state.zReportId != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showReportModal(context: context, id: state.zReportId!);
            });
          }
        }
        return const SizedBox();
      },
    );
  }
}
