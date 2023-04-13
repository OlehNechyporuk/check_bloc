import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_bloc/core/extesions.dart';
import 'package:check_bloc/features/cash_register/domain/entity/product_entity.dart';
import 'package:check_bloc/features/cash_register/presentation/blocs/receipt_bloc/receipt_bloc.dart';

class ProductRowWidget extends StatelessWidget {
  final ProductEntity product;

  const ProductRowWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(text: product.price.toUAH());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.name,
          style: const TextStyle(fontSize: 15),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(product.code),
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
