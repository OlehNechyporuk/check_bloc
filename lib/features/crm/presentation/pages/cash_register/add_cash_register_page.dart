import 'package:check_bloc/config/constants.dart';
import 'package:check_bloc/core/snakbar/snakbars.dart';
import 'package:check_bloc/features/crm/presentation/blocs/add_cash_register_crm_bloc/add_cash_register_crm_bloc.dart';
import 'package:check_bloc/features/crm/presentation/blocs/cash_register_crm_bloc/cash_register_crm_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AddCashRegisterPage extends StatelessWidget {
  const AddCashRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Додати касу'),
        centerTitle: false,
      ),
      body: const AddRegisterFromWidget(),
    );
  }
}

class AddRegisterFromWidget extends StatefulWidget {
  const AddRegisterFromWidget({super.key});

  @override
  State<AddRegisterFromWidget> createState() => _AddRegisterFromWidgetState();
}

class _AddRegisterFromWidgetState extends State<AddRegisterFromWidget> {
  int _typeId = 1;
  String? _title;

  void updateTypeId(int typeId) {
    setState(() {
      _typeId = typeId;
    });
  }

  void updateTitle(String? title) {
    setState(() {
      _title = title;
    });
  }

  bool get canSubmit {
    if (_title == null || _title!.isEmpty) {
      return false;
    }
    return true;
  }

  submit(BuildContext context) {
    final title = _title;
    if (title != null) {
      context.read<AddCashRegisterCrmBloc>().add(
            AddCashRegisterAddCrmEvent(
              title: title,
              typeId: _typeId,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddCashRegisterCrmBloc, AddCashRegisterCrmState>(
      listener: (context, state) {
        if (state.status == BlocStateStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            showSuccessSnakbar('Added'),
          );

          context.pop();
          context
              .read<CashRegisterCrmBloc>()
              .add(CashRegisterCrmLoadedListEvent());
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CashRegisterTypeFileds(
              updateTypeId: updateTypeId,
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              onChanged: (val) {
                updateTitle(val);
              },
              autocorrect: false,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Вкажіть назву',
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            BlocBuilder<AddCashRegisterCrmBloc, AddCashRegisterCrmState>(
              builder: (context, state) {
                if (state.status == BlocStateStatus.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: canSubmit
                          ? () {
                              submit(context);
                            }
                          : null,
                      child: const Text('Додати касу'),
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

class CashRegisterTypeFileds extends StatelessWidget {
  final Function updateTypeId;

  const CashRegisterTypeFileds({
    super.key,
    required this.updateTypeId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CashRegisterCrmBloc, CashRegisterCrmState>(
      builder: (context, state) {
        if (state.status == BlocStateStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final list = <DropdownMenuItem>[];
        if (state.status == BlocStateStatus.success) {
          final types = state.types;
          if (types != null) {
            for (var element in types) {
              list.add(
                DropdownMenuItem(
                  value: element.id,
                  child: Text(element.title),
                ),
              );
            }
          }
        }

        return DropdownButtonFormField(
          value: state.types?.first.id,
          elevation: 2,
          items: [...list],
          onChanged: (val) {
            updateTypeId(val);
          },
        );
      },
    );
  }
}
