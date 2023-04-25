import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:check_bloc/config/constants.dart';
import 'package:check_bloc/config/main_navigation_name.dart';
import 'package:check_bloc/features/cash_register/presentation/blocs/auth_bloc/auth_bloc.dart';

class SplashPageCashRegister extends StatelessWidget {
  final String? type;
  final String? title;
  final String? cashRegisterId;
  final String? crmRegisterTitle;
  const SplashPageCashRegister({
    super.key,
    required this.type,
    required this.title,
    required this.cashRegisterId,
    required this.crmRegisterTitle,
  });

  @override
  Widget build(BuildContext context) {
    if (cashRegisterId != null) {
      context
          .read<AuthBloc>()
          .add(AuthChangeCurrentCashRegisterEvent(cashRegisterId!));
      context.read<AuthBloc>().add(AutCheckEvent());
    }
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == BlocStateStatus.success) {
          context.goNamed(CashRegisterNavigationName.homePage);
        } else {
          context.goNamed(
            CashRegisterNavigationName.loginPage,
            params: {
              'type': '$type',
              'title': '$title',
              'cash_register': '$cashRegisterId',
              'crm_title': '$crmRegisterTitle',
            },
          );
        }
      },
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Center(child: Text('$title')),
          ],
        ),
      ),
    );
  }
}
