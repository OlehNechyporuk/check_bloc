import 'package:check_bloc/presentation/pages/home/wigets/products_widget.dart';
import 'package:check_bloc/presentation/pages/home/wigets/receipt_widget.dart';
import 'package:check_bloc/presentation/pages/home/wigets/search_product_widget.dart';
import 'package:flutter/material.dart';

class SellTab extends StatelessWidget {
  const SellTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: const [
          SearchProductWiget(),
          SizedBox(height: 5),
          Expanded(flex: 1, child: ProductsWidget()),
          ReceiptWidget(),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
