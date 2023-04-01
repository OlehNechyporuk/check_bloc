import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';

showReceiptModal({
  required BuildContext context,
  required String id,
  String type = 'html',
  goHome = false,
}) {
  final controller = WebViewController();

  try {
    controller.loadRequest(
      Uri.parse('https://api.checkbox.in.ua/api/v1/receipts/$id/$type'),
    );
  } catch (e) {
    rethrow;
  }

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        contentPadding: const EdgeInsets.all(5),
        insetPadding: const EdgeInsets.all(0),
        content: SizedBox(
          width: double.maxFinite,
          child: WebViewWidget(controller: controller),
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
