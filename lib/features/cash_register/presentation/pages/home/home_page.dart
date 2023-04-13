import 'package:flutter/material.dart';

import 'package:check_bloc/features/cash_register/presentation/pages/home/wigets/header_widget.dart';
import 'package:check_bloc/features/cash_register/presentation/pages/home/wigets/tabs_widget.dart';
import 'package:check_bloc/features/cash_register/presentation/widgets/bottom_nav_widget.dart';
import 'package:check_bloc/features/cash_register/presentation/widgets/custom_drawer.dart';

final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: Column(
          children: const [
            HeaderWiget(),
            SizedBox(height: 10),
            Expanded(
              flex: 1,
              child: TabsWidget(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavWidget(
        drawerKey: _drawerKey,
      ),
    );
  }
}
