import 'package:check_bloc/presentation/blocs/bottom_nav_bloc/bottom_navbar_bloc.dart';
import 'package:check_bloc/presentation/pages/home/tabs/return_tab.dart';
import 'package:check_bloc/presentation/pages/home/tabs/sell_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabsWidget extends StatelessWidget {
  const TabsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavbarBloc, BottomNavbarState>(
      builder: (context, state) {
        if (state.index == 0) {
          return const SellTab();
        } else if (state.index == 1) {
          return const RetutnTab();
        }
        return Container();
      },
    );
  }
}
