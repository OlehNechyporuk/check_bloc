import 'package:check_bloc/presentation/blocs/bottom_nav_bloc/bottom_navbar_bloc.dart';
import 'package:check_bloc/presentation/widgets/barcode_scanner_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.arrow_circle_right_outlined),
              label: 'Продаж',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.arrow_circle_left_outlined),
              label: 'Повернення',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.qr_code),
              label: 'Сканнер',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: 'Меню',
            ),
          ],
        );
      },
    );
  }
}
