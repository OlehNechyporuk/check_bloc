import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

showReceiptModal({
  required BuildContext context,
  required String id,
  String type = 'png',
  goHome = false,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        contentPadding: const EdgeInsets.all(5),
        insetPadding: const EdgeInsets.all(0),
        content: Container(
          alignment: Alignment.center,
          width: double.maxFinite,
          height: double.maxFinite,
          child: SingleChildScrollView(
            child: Image.network(
              'https://api.checkbox.in.ua/api/v1/receipts/$id/$type',
              loadingBuilder: (context, child, loadingProgress) {
                return loadingProgress == null
                    ? child
                    : const CircularProgressIndicator();
              },
              errorBuilder: (context, error, stackTrace) => Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('Помилка, при загрузці чеку, спробуйте ще раз'),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          context.pop();
                          showReceiptModal(context: context, id: id);
                        });
                      },
                      child: const Icon(Icons.refresh),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        actionsPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.print),
            iconSize: 42,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.share),
            iconSize: 42,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.download),
            iconSize: 42,
          ),
          IconButton(
            onPressed: () {
              context.pop();
              if (goHome) {
                context.pop();
              }
            },
            iconSize: 42,
            icon: const Icon(
              Icons.done,
            ),
          ),
        ],
      );
    },
  );
}
