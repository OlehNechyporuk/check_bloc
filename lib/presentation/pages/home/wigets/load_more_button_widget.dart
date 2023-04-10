import 'package:check_bloc/presentation/blocs/products_bloc/products_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                const Icon(Icons.refresh_outlined),
                Text('${AppLocalizations.of(context)?.loadMore}')
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
