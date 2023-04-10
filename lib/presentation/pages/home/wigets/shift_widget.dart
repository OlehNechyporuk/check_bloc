import 'package:check_bloc/presentation/blocs/shift_bloc/shift_bloc.dart';
import 'package:check_bloc/presentation/pages/home/wigets/open_shift_widget.dart';
import 'package:check_bloc/presentation/pages/home/wigets/shift_closed_widget.dart';
import 'package:check_bloc/presentation/pages/home/wigets/shift_opening_time_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShiftWidget extends StatelessWidget {
  const ShiftWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text('${AppLocalizations.of(context)?.shift}'),
            const SizedBox(
              width: 10,
            ),
            BlocBuilder<ShiftBloc, ShiftState>(
              builder: (context, state) {
                if (state.shift == null) {
                  return const ShiftClosedWidget();
                } else {
                  return const OpenShiftWidget();
                }
              },
            ),
            const SizedBox(),
          ],
        ),
        const ShiftOpeningTimeWidget(),
      ],
    );
  }
}
