import 'package:check_bloc/config/constants.dart';
import 'package:check_bloc/presentation/blocs/products_bloc/products_bloc.dart';
import 'package:check_bloc/presentation/pages/home/wigets/load_more_button_widget.dart';
import 'package:check_bloc/presentation/pages/home/wigets/product_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductsWidget extends StatelessWidget {
  const ProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (context, state) {
        if (state.status == BlocStateStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state.status == BlocStateStatus.success) {
          return state.products.isEmpty
              ? Center(
                  child: Text('${AppLocalizations.of(context)?.notFound}'),
                )
              : ListView.separated(
                  itemCount: state.products.length + 1,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    return index == state.products.length
                        ? const LoadMoreButtonWidget()
                        : ProductRowWidget(
                            product: state.products[index],
                          );
                  },
                );
        }

        return const SizedBox();
      },
    );
  }
}
