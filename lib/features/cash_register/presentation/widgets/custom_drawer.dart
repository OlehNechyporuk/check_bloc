import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import 'package:check_bloc/config/constants.dart';
import 'package:check_bloc/config/main_navigation_name.dart';
import 'package:check_bloc/features/cash_register/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:check_bloc/features/cash_register/presentation/blocs/bottom_nav_bloc/bottom_navbar_bloc.dart';
import 'package:check_bloc/features/cash_register/presentation/blocs/cashier_bloc/cashier_bloc.dart';
import 'package:check_bloc/features/cash_register/presentation/pages/home/wigets/show_cash_in_form_modal.dart';
import 'package:check_bloc/features/cash_register/presentation/pages/home/wigets/show_cash_out_form_modal.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const _Organization(),
          const _CashierInfo(),
          ListTile(
            title: Text(
              '${AppLocalizations.of(context)?.opetations}',
              style: const TextStyle(fontSize: 22),
            ),
          ),
          ListTile(
            title: Text(
              '${AppLocalizations.of(context)?.sellNav}',
              style: const TextStyle(fontSize: 16),
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
            title: Text(
              '${AppLocalizations.of(context)?.returnNav}',
              style: const TextStyle(fontSize: 16),
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
            title: Text(
              '${AppLocalizations.of(context)?.cashIn}',
              style: const TextStyle(fontSize: 16),
            ),
            leading: const Icon(Icons.arrow_upward_outlined),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              context.pop();
              showCashInFormModal(context);
            },
          ),
          ListTile(
            title: Text(
              '${AppLocalizations.of(context)?.cashOut}',
              style: const TextStyle(fontSize: 16),
            ),
            leading: const Icon(Icons.arrow_downward_outlined),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              context.pop();
              showCasOutFormModal(context);
            },
          ),
          ListTile(
            title: Text(
              '${AppLocalizations.of(context)?.cashRegister}',
              style: const TextStyle(fontSize: 22),
            ),
          ),
          ListTile(
            title: Text(
              '${AppLocalizations.of(context)?.cashRegisterSettings}',
              style: const TextStyle(fontSize: 16),
            ),
            leading: const Icon(Icons.settings),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              context.pop();
              context.pushNamed(CashRegisterNavigationName.cashRegisterPage);
            },
          ),
          ListTile(
            title: Text(
              '${AppLocalizations.of(context)?.receiptsHistory}',
              style: const TextStyle(fontSize: 16),
            ),
            leading: const Icon(Icons.receipt_long),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              context.pop();
              context.pushNamed(CashRegisterNavigationName.receiptHistoryPage);
            },
          ),
          ListTile(
            title: Text(
              '${AppLocalizations.of(context)?.workShifts}',
              style: const TextStyle(fontSize: 16),
            ),
            leading: const Icon(Icons.people_alt),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              context.pop();
              context.pushNamed(CashRegisterNavigationName.reportsHistoryPage);
            },
          ),
        ],
      ),
    );
  }
}

class _Organization extends StatelessWidget {
  const _Organization();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CashierBloc, CashierState>(
      builder: (context, state) {
        if (state.status == BlocStateStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.status == BlocStateStatus.success) {
          return ListTile(
            title: Text('${state.cashier?.organization?.title}'),
            subtitle: Text('${state.cashier?.organization?.edrpou}'),
          );
        } else {
          return const SizedBox();
        }
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
        if (state.status == BlocStateStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.status == BlocStateStatus.success) {
          return ListTile(
            title: Text('${state.cashier?.fullName}'),
            leading: const Icon(Icons.person),
            trailing: const Icon(Icons.logout),
            onTap: () {
              context.read<AuthBloc>().add(const AuthLogoutEvent());
              context.goNamed(MainNavigationName.dashboarCrm);
            },
          );
        } else {
          return Center(
            child: Text('${state.errorText}'),
          );
        }
      },
    );
  }
}
