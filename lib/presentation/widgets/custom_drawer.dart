import 'package:check_bloc/config/main_navigation_name.dart';
import 'package:check_bloc/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:check_bloc/presentation/blocs/bottom_nav_bloc/bottom_navbar_bloc.dart';
import 'package:check_bloc/presentation/blocs/cashier_bloc/cashier_bloc.dart';
import 'package:check_bloc/presentation/pages/home/wigets/shift_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CashierBloc>().add(CashierLoadEvent());
    return Drawer(
      child: ListView(children: [
        const _Organization(),
        const _CashierInfo(),
        const ListTile(
          title: Text(
            'Операції',
            style: TextStyle(fontSize: 22),
          ),
        ),
        ListTile(
          title: const Text(
            'Продаж',
            style: TextStyle(fontSize: 16),
          ),
          leading: const Icon(Icons.arrow_circle_right_outlined),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            context.pop();
            BlocProvider.of<BottomNavbarBloc>(context)
                .add(const BottomNavbarChangeTabEvent(0));
          },
        ),
        ListTile(
          title: const Text(
            'Повернення',
            style: TextStyle(fontSize: 16),
          ),
          leading: const Icon(Icons.arrow_circle_left_outlined),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            context.pop();
            BlocProvider.of<BottomNavbarBloc>(context)
                .add(const BottomNavbarChangeTabEvent(1));
          },
        ),
        ListTile(
          title: const Text(
            'Внести готівку',
            style: TextStyle(fontSize: 16),
          ),
          leading: const Icon(Icons.arrow_upward_outlined),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            context.pop();
            showCashInForm(context);
          },
        ),
        ListTile(
          title: const Text(
            'Видати готівку',
            style: TextStyle(fontSize: 16),
          ),
          leading: const Icon(Icons.arrow_downward_outlined),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            context.pop();
            showCasOutForm(context);
          },
        ),
        const ListTile(
          title: Text(
            'Каса',
            style: TextStyle(fontSize: 22),
          ),
        ),
        ListTile(
          title: const Text(
            'Налаштування',
            style: TextStyle(fontSize: 16),
          ),
          leading: const Icon(Icons.settings),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            context.pop();
            context.pushNamed(MainNavigationName.cashRegisterPage);
          },
        ),
        ListTile(
          title: const Text(
            'Історія чеків',
            style: TextStyle(fontSize: 16),
          ),
          leading: const Icon(Icons.receipt_long),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            context.pop();
            context.pushNamed(MainNavigationName.receiptHistoryPage);
          },
        ),
        ListTile(
          title: const Text(
            'Робочі зміни',
            style: TextStyle(fontSize: 16),
          ),
          leading: const Icon(Icons.people_alt),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            context.pop();
            context.pushNamed(MainNavigationName.cashRegisterPage);
          },
        ),
      ]),
    );
  }
}

class _Organization extends StatelessWidget {
  const _Organization();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CashierBloc, CashierState>(
      builder: (context, state) {
        final cashier = context.watch<CashierBloc>();
        return ListTile(
          title: Text(cashier.state.cashier?.organization?.title ?? ''),
          subtitle: Text(cashier.state.cashier?.organization?.edrpou ?? ''),
        );
      },
    );
  }
}

class _CashierInfo extends StatelessWidget {
  const _CashierInfo();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CashierBloc, CashierState>(
      builder: (context, state) {
        final cashier = context.watch<CashierBloc>();
        return ListTile(
          title: Text(cashier.state.cashier?.fullName ?? ''),
          leading: const Icon(Icons.person),
          trailing: const Icon(Icons.logout),
          onTap: () => context.read<AuthBloc>().add(AuthLogoutEvent()),
        );
      },
    );
  }
}
