import 'package:check_bloc/config/constants.dart';
import 'package:check_bloc/config/main_navigation_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:check_bloc/features/cash_register/presentation/blocs/login_form_bloc/login_form_bloc.dart';
import 'package:check_bloc/features/cash_register/presentation/widgets/button_widget.dart';
import 'package:check_bloc/features/cash_register/presentation/widgets/input_widget.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  final String? type;
  final String? title;
  final String cashRegisterId;
  final String crmRegisterTitle;
  const LoginPage({
    super.key,
    required this.type,
    required this.title,
    required this.cashRegisterId,
    required this.crmRegisterTitle,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginFormBloc, LoginFormState>(
      listener: (context, state) {
        if (state.status == BlocStateStatus.success) {
          context.goNamed(
            CashRegisterNavigationName.splashPageCashRegister,
            params: {
              'type': '$type',
              'title': '$title',
              'cash_register': cashRegisterId,
              'crm_title': crmRegisterTitle,
            },
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(crmRegisterTitle),
          centerTitle: false,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '$title',
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(
                  height: 15,
                ),
                InputWidget(
                  onChanged: (value) => context
                      .read<LoginFormBloc>()
                      .add(LoginFormUserNameChangeEvent(value)),
                  label: '${AppLocalizations.of(context)?.loginLabel}',
                  suffixIcon: const Icon(Icons.person),
                  errorText: null,
                ),
                const SizedBox(
                  height: 20,
                ),
                InputWidget(
                  onChanged: (value) => context
                      .read<LoginFormBloc>()
                      .add(LoginFormPasswordChangeEvent(value)),
                  label: '${AppLocalizations.of(context)?.passwordLabel}',
                  obscureText: true,
                  suffixIcon: const Icon(Icons.lock),
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocBuilder<LoginFormBloc, LoginFormState>(
                  builder: (context, state) {
                    if (state.isSubmit) {
                      return const CircularProgressIndicator();
                    } else {
                      return Column(
                        children: [
                          if (state.errorText.isNotEmpty)
                            Text(
                              state.errorText,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.red,
                              ),
                            ),
                          const SizedBox(
                            height: 20,
                          ),
                          ButtonWidget(
                            onPressed: state.canSubmit
                                ? () => context.read<LoginFormBloc>().add(
                                      LoginFormSubmitEvent(cashRegisterId),
                                    )
                                : null,
                            label:
                                '${AppLocalizations.of(context)?.loginButton}',
                          ),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
