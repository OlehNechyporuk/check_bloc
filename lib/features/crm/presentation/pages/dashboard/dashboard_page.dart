import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:check_bloc/config/constants.dart';
import 'package:check_bloc/config/main_navigation_name.dart';
import 'package:check_bloc/features/crm/presentation/blocs/cash_register_crm_bloc/cash_register_crm_bloc.dart';
import 'package:check_bloc/features/crm/presentation/blocs/user_crm_bloc/user_crm_bloc.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<UserCrmBloc, UserCrmState>(
          builder: (context, state) {
            if (state.status == BlocStateStatus.success) {
              return Text('${state.user?.lastName} ${state.user?.firstName}');
            }
            return const SizedBox();
          },
        ),
        centerTitle: false,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              'Каси',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const CashRegisterCrmList(),
            ElevatedButton(
              onPressed: () {
                context
                    .read<CashRegisterCrmBloc>()
                    .add(CashRegisterCrmLoadedTypesListEvent());
                context.pushNamed(MainNavigationName.addCashRegisterCrm);
              },
              child: const Text('Додати касу'),
            ),
          ],
        ),
      ),
    );
  }
}

class CashRegisterCrmList extends StatelessWidget {
  const CashRegisterCrmList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CashRegisterCrmBloc, CashRegisterCrmState>(
      builder: (context, state) {
        if (state.status == BlocStateStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.status == BlocStateStatus.success) {
          final registers = state.registers;
          final List<Widget> children = [];

          if (registers != null) {
            for (final register in registers) {
              children.add(
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(register.title),
                  subtitle: Text(register.type.title),
                  onTap: () {
                    context.goNamed(
                      CashRegisterNavigationName.splashPageCashRegister,
                      params: {
                        'type': '${register.type.id}',
                        'title': register.type.title,
                        'cash_register': '${register.id}',
                        'crm_title': register.title
                      },
                    );
                  },
                ),
              );
            }

            return Column(
              children: children,
            );
          }
        }

        return const SizedBox();
      },
    );
  }
}
