import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:check_bloc/features/cash_register/presentation/blocs/products_bloc/products_bloc.dart';

class SearchProductWiget extends StatelessWidget {
  const SearchProductWiget({super.key});

  @override
  Widget build(BuildContext context) {
    Timer? timer;
    return Row(
      children: [
        Expanded(
          child: TextField(
            onChanged: (value) {
              if (timer != null) {
                timer?.cancel();
              }
              timer = Timer(const Duration(milliseconds: 350), () {
                context.read<ProductsBloc>().add(ProductsSearchEvent(value));
              });
            },
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              label: Text('${AppLocalizations.of(context)?.searchLabel}'),
              prefixIcon: const Icon(Icons.search),
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.add),
          alignment: Alignment.centerRight,
        ),
      ],
    );
  }
}
