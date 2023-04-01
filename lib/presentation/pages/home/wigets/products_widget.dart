import 'package:check_bloc/domain/entity/product.dart';
import 'package:check_bloc/main.dart';
import 'package:check_bloc/presentation/blocs/products_bloc/products_bloc.dart';
import 'package:check_bloc/presentation/blocs/receipt_bloc/receipt_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsWidget extends StatelessWidget {
  const ProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (context, state) {
        return ListView.separated(
          itemCount: state.products.length + 1,
          separatorBuilder: (context, index) => const SizedBox(height: 15),
          itemBuilder: (context, index) {
            return index == state.products.length
                ? const _LoadMoreButton()
                : _ProductRow(state.products[index], index);
          },
        );
      },
    );
  }
}

class _ProductRow extends StatelessWidget {
  final Product product;
  final int index;

  const _ProductRow(this.product, this.index);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.name ?? '',
          style: const TextStyle(fontSize: 16),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(product.code ?? ''),
            Row(
              children: [
                SizedBox(
                  width: 90,
                  height: 30,
                  child: TextFormField(
                    autofocus: false,
                    onChanged: (value) {
                      context.read<ReceiptBloc>().add(
                            ReceiptUpdateGoodPriceEvent(double.tryParse(value)),
                          );
                    },
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^\d+\.?\d{0,2}'),
                      ),
                    ],
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      suffix: Text('₴'),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                    ),
                    initialValue: product.price?.toUAH(),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    context
                        .read<ReceiptBloc>()
                        .add(ReceiptAddGoodEvent(product));
                  },
                  icon: const Icon(Icons.add),
                )
              ],
            )
          ],
        ),
      ],
    );
  }
}

class _LoadMoreButton extends StatelessWidget {
  const _LoadMoreButton();

  @override
  Widget build(BuildContext context) {
    final show = context.watch<ProductsBloc>().state.showLoadMoreButton;
    return show
        ? TextButton(
            onPressed: () =>
                context.read<ProductsBloc>().add(ProductsLoadMoreEvent()),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.refresh_outlined),
                Text('Завантажити більше')
              ],
            ),
          )
        : const Text('');
  }
}
