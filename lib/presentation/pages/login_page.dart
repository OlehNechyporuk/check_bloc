import 'package:check_bloc/presentation/blocs/login_form_bloc/login_form_bloc.dart';
import 'package:check_bloc/presentation/widgets/button_widget.dart';
import 'package:check_bloc/presentation/widgets/input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InputWidget(
                onChanged: (value) => context
                    .read<LoginFormBloc>()
                    .add(LoginFormUserNameChangeEvent(value)),
                label: 'Логін касира',
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
                label: 'Пароль касира',
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
                                fontSize: 14, color: Colors.red),
                          ),
                        const SizedBox(
                          height: 20,
                        ),
                        ButtonWidget(
                          onPressed: state.canSubmit
                              ? () => context
                                  .read<LoginFormBloc>()
                                  .add(const LoginFormSubmitEvent())
                              : null,
                          label: 'Увійти',
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
    );
  }
}
