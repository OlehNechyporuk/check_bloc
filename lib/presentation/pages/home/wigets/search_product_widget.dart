import 'dart:async';

import 'package:check_bloc/presentation/blocs/products_bloc/products_bloc.dart';
import 'package:check_bloc/presentation/widgets/input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchProductWiget extends StatelessWidget {
  const SearchProductWiget({super.key});

  @override
  Widget build(BuildContext context) {
    Timer? timer;
    return Row(
      children: [
        Expanded(
          child: InputWidget(
            onChanged: (value) {
              if (timer != null) {
                timer?.cancel();
              }
              timer = Timer(const Duration(milliseconds: 400), () {
                context.read<ProductsBloc>().add(ProductsSearchEvent(value));
              });
            },
            label: 'Пошук',
            prefixIcon: const Icon(Icons.search),
            padding: const EdgeInsets.all(10),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.add),
        )
      ],
    );
  }
}
