import 'package:check_bloc/config/constants.dart';
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
    return BlocListener<ProductsBloc, ProductsState>(
      listener: (context, state) {
        if (state.status == BlocStateStatus.failure) {
          if (state.errorText != null) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('${state.errorText}')));
          }
        }
      },
      child: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          if (state.status == BlocStateStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.status == BlocStateStatus.success) {
            return state.products.isEmpty
                ? const Center(
                    child: Text('Не знайдено'),
                  )
                : ListView.separated(
                    itemCount: state.products.length + 1,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      return index == state.products.length
                          ? const _LoadMoreButton()
                          : _ProductRow(
                              product: state.products[index],
                            );
                    },
                  );
          }

          return const SizedBox();
        },
      ),
    );
  }
}

class _ProductRow extends StatelessWidget {
  final Product product;

  const _ProductRow({required this.product});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(text: product.price?.toUAH());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.name ?? '',
          style: const TextStyle(fontSize: 15),
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
                            ReceiptUpdateGoodPriceEvent(
                              double.tryParse(controller.text),
                            ),
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
                    controller: controller,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    context
                        .read<ReceiptBloc>()
                        .add(ReceiptAddGoodEvent(product));
                  },
                  icon: const ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    child: ColoredBox(
                      color: Colors.grey,
                      child: Icon(
                        Icons.add,
                      ),
                    ),
                  ),
                  enableFeedback: false,
                  splashRadius: 0.01,
                  color: Colors.white,
                  padding: const EdgeInsets.all(0),
                  alignment: Alignment.centerRight,
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
