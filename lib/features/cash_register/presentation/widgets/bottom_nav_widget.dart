import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:check_bloc/features/cash_register/presentation/blocs/bottom_nav_bloc/bottom_navbar_bloc.dart';
import 'package:check_bloc/features/cash_register/presentation/widgets/barcode_scanner_modal.dart';

class BottomNavWidget extends StatelessWidget {
  final GlobalKey<ScaffoldState> drawerKey;
  const BottomNavWidget({super.key, required this.drawerKey});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavbarBloc, BottomNavbarState>(
      builder: (context, state) {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: state.index,
          unselectedFontSize: 14,
          selectedFontSize: 14,
          selectedItemColor: Theme.of(context).primaryColor,
          onTap: (value) {
            if (value < 2) {
              BlocProvider.of<BottomNavbarBloc>(context)
                  .add(BottomNavbarChangeTabEvent(value));
            } else {
              if (drawerKey.currentState!.isDrawerOpen) {
                drawerKey.currentState!.openEndDrawer();
              } else if (value == 2) {
                barcodeScannerModal(context: context);
              } else if (value == 3) {
                drawerKey.currentState!.openDrawer();
              }
            }
          },
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.arrow_circle_right_outlined),
              label: '${AppLocalizations.of(context)?.sellNav}',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.arrow_circle_left_outlined),
              label: '${AppLocalizations.of(context)?.returnNav}',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.qr_code),
              label: '${AppLocalizations.of(context)?.scannerNav}',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.menu),
              label: '${AppLocalizations.of(context)?.menuNav}',
            ),
          ],
        );
      },
    );
  }
}
