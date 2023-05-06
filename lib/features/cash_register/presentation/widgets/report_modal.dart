import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:check_bloc/config/constants.dart';
import 'package:check_bloc/features/cash_register/presentation/blocs/modal_report_bloc/modal_report_bloc.dart';

showReportModal({
  required BuildContext context,
  required String id,
}) {
  showDialog(
    context: context,
    builder: (context) {
      context.read<ModalReportBloc>().add(ModalReportLoadedEvent(id));
      return AlertDialog(
        insetPadding: EdgeInsets.zero,
        contentPadding: const EdgeInsets.only(left: 5),
        content: const ReportContent(),
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
            },
            child: const Text(
              'close',
            ),
          ),
        ],
      );
    },
  );
}

class ReportContent extends StatelessWidget {
  const ReportContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<ModalReportBloc, ModalReportState>(
        builder: (context, state) {
          if (state.status == BlocStateStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.status == BlocStateStatus.success) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Center(
                    child: Text(
                      '${state.report}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            );
          }

          if (state.status == BlocStateStatus.failure) {
            return Center(child: Text('${state.errorText}'));
          }

          return const SizedBox();
        },
      ),
    );
  }
}
