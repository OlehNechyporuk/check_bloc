import 'dart:async';

import 'package:check_bloc/presentation/blocs/products_bloc/products_bloc.dart';
// import 'package:check_bloc/presentation/widgets/barcode_scanner_modal.dart';
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
          child: TextField(
            onChanged: (value) {
              if (timer != null) {
                timer?.cancel();
              }
              timer = Timer(const Duration(milliseconds: 350), () {
                context.read<ProductsBloc>().add(ProductsSearchEvent(value));
              });
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              label: Text('Пошук'),
              prefixIcon: Icon(Icons.search),
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
        // IconButton(
        //   onPressed: () {
        //     barcodeScannerModal(context: context);
        //   },
        //   icon: const Icon(Icons.qr_code),
        //   padding: EdgeInsets.zero,
        //   splashRadius: 0.1,
        //   alignment: Alignment.centerRight,
        // )
      ],
    );
  }
}
