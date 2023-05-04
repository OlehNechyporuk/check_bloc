import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:check_bloc/config/constants.dart';
import 'package:check_bloc/core/snakbar/snakbars.dart';
import 'package:check_bloc/features/crm/presentation/blocs/auth_crm_bloc/auth_crm_bloc.dart';

class LoginPageCrm extends StatefulWidget {
  const LoginPageCrm({super.key});

  @override
  State<LoginPageCrm> createState() => _LoginPageCrmState();
}

class _LoginPageCrmState extends State<LoginPageCrm> {
  final loginController = TextEditingController();
  final passwordController = TextEditingController();

  bool get canSubmit {
    if (loginController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      return true;
    }

    return false;
  }

  void update() {
    setState(() {});
  }

  submit(BuildContext context) {
    context.read<AuthCrmBloc>().add(
          AuthCrmLoginEvent(
            login: loginController.text,
            password: passwordController.text,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCrmBloc, AuthCrmState>(
      listener: (context, state) {
        if (state.status == BlocStateStatus.failure &&
            state.errorText != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            showErrorSnakbar('${state.errorText}'),
          );
        }
      },
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: loginController,
                    onChanged: (value) => update(),
                    // onSubmitted: canSubmit ? (value) => submit(context) : null,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: '${AppLocalizations.of(context)?.loginLabel}',
                      suffixIcon: const Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: passwordController,
                    onChanged: (value) => update(),
                    // onSubmitted: canSubmit ? (value) => submit(context) : null,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText:
                          '${AppLocalizations.of(context)?.passwordLabel}',
                      suffixIcon: const Icon(Icons.lock),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<AuthCrmBloc, AuthCrmState>(
                    builder: (context, state) {
                      return SizedBox(
                        height: 60,
                        width: double.maxFinite,
                        child: ElevatedButton(
                          onPressed: canSubmit &&
                                  state.status != BlocStateStatus.loading
                              ? () => submit(context)
                              : null,
                          child: state.status == BlocStateStatus.loading
                              ? const Center(child: CircularProgressIndicator())
                              : Text(
                                  '${AppLocalizations.of(context)?.loginButton}',
                                  style: const TextStyle(fontSize: 18),
                                ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
