import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:check_bloc/features/cash_register/presentation/blocs/products_bloc/products_bloc.dart';

class LoadMoreButtonWidget extends StatelessWidget {
  const LoadMoreButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (context, state) {
        if (state.showLoadMoreButton) {
          return TextButton(
            onPressed: () =>
                context.read<ProductsBloc>().add(ProductsLoadMoreEvent()),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.refresh_outlined,
                  color: Theme.of(context).primaryColor,
                ),
                Text(
                  '${AppLocalizations.of(context)?.loadMore}',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                )
              ],
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
