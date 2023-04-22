import 'package:check_bloc/config/constants.dart';
import 'package:check_bloc/config/main_navigation_name.dart';
import 'package:check_bloc/features/cash_register/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashPageCashRegister extends StatelessWidget {
  final String? type;
  final String? title;
  final String? cashRegisterId;
  const SplashPageCashRegister({
    super.key,
    required this.type,
    required this.title,
    required this.cashRegisterId,
  });

  @override
  Widget build(BuildContext context) {
    if (cashRegisterId != null) {
      context.read<AuthBloc>().add(AutCheckEvent(cashRegisterId!));
    }

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == BlocStateStatus.success) {
          context.pushReplacementNamed(CashRegisterNavigationName.homePage);
        } else {
          context.pushReplacementNamed(CashRegisterNavigationName.loginPage);
        }
      },
      child: Scaffold(
        body: Center(child: Text('$title')),
      ),
    );
  }
}
