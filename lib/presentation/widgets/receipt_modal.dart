import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;

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
        contentPadding: const EdgeInsets.all(10),
        insetPadding: const EdgeInsets.all(10),
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
          // IconButton(
          //   onPressed: () {},
          //   icon: const Icon(Icons.print),
          //   iconSize: 42,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Share.share(
                        'https://check.checkbox.ua/62a1112f-876e-49d8-a5f8-e44222d56a89',
                      );
                    },
                    icon: const Icon(Icons.share),
                    iconSize: 42,
                  ),
                  const SizedBox(width: 30),
                  IconButton(
                    onPressed: () async {
                      final response = await http.get(
                        Uri.parse(
                          'https://api.checkbox.in.ua/api/v1/receipts/$id/pdf',
                        ),
                      );

                      Share.shareXFiles([
                        XFile.fromData(
                          response.bodyBytes,
                          mimeType: 'pdf',
                          name: id,
                        ),
                      ]);
                    },
                    icon: const Icon(Icons.download),
                    iconSize: 42,
                  ),
                ],
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
          ),
        ],
      );
    },
  );
}
