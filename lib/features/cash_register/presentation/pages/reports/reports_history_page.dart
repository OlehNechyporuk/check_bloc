import 'package:check_bloc/features/cash_register/presentation/widgets/report_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:check_bloc/config/constants.dart';
import 'package:check_bloc/core/extesions.dart';
import 'package:check_bloc/features/cash_register/domain/entity/shift_entity.dart';
import 'package:check_bloc/features/cash_register/presentation/blocs/shifts_history_bloc+/shifts_history_bloc.dart';

class ReportsHistoryPage extends StatelessWidget {
  const ReportsHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ShiftsHistoryBloc>().add(ShiftsHistoryLoadedEvent());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Робочі зміни'),
        centerTitle: false,
      ),
      body: const ShiftsList(),
    );
  }
}

class ShiftsList extends StatelessWidget {
  const ShiftsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShiftsHistoryBloc, ShiftsHistoryState>(
      builder: (context, state) {
        if (state.status == BlocStateStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state.status == BlocStateStatus.success) {
          return state.shifts.isEmpty
              ? Center(
                  child: Text('${AppLocalizations.of(context)?.notFound}'),
                )
              : ListView.separated(
                  itemCount: state.shifts.length + 1,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    return index == state.shifts.length
                        ? const LoadMoreShiftButton()
                        : ShiftRowWidget(
                            shift: state.shifts[index],
                          );
                  },
                );
        }

        return const SizedBox();
      },
    );
  }
}

class LoadMoreShiftButton extends StatelessWidget {
  const LoadMoreShiftButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}

class ShiftRowWidget extends StatelessWidget {
  final ShiftEntity shift;
  const ShiftRowWidget({Key? key, required this.shift}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ShiftStatusWidget(status: shift.status),
            const SizedBox(width: 10),
            Text('Каса ${shift.cashRegister.fiscalNumber}'),
            const SizedBox(width: 10),
            Text('Зміна: ${shift.serial}'),
          ],
        ),
        subtitle: Row(
          children: [
            const Icon(
              Icons.schedule_outlined,
              size: 14,
            ),
            const SizedBox(width: 5),
            Text('${shift.openedAt?.toLocalTime()}'),
            const SizedBox(width: 5),
            Text(shift.closedAt?.toLocalTime() ?? ''),
          ],
        ),
        trailing: PopupMenuButton(
          elevation: 4,
          padding: EdgeInsets.zero,
          icon: const Icon(Icons.more_vert_outlined),
          itemBuilder: (BuildContext context) => [
            PopupMenuItem(
              onTap: () {
                final id = shift.zReport?.id;
                if (id != null) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    showReportModal(context: context, id: id);
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
          ],
        ),
      ),
    );
  }
}

class ShiftStatusWidget extends StatelessWidget {
  final String status;
  const ShiftStatusWidget({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (status == 'OPENED') {
      return const ColoredBox(
        color: Colors.green,
        child: SizedBox(
          width: 5,
          height: 10,
        ),
      );
    } else {
      return ColoredBox(
        color: Colors.red.shade400,
        child: const SizedBox(
          width: 5,
          height: 10,
        ),
      );
    }
  }
}
