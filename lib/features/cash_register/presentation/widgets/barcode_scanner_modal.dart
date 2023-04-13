import 'package:check_bloc/features/cash_register/presentation/blocs/receipt_bloc/receipt_bloc.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

barcodeScannerModal({
  required BuildContext context,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return const _BarcodeScanner();
    },
  );
}

class _BarcodeScanner extends StatefulWidget {
  const _BarcodeScanner();

  @override
  State<_BarcodeScanner> createState() => __BarcodeScannerState();
}

class __BarcodeScannerState extends State<_BarcodeScanner> {
  final controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    facing: CameraFacing.back,
  );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(5),
      contentPadding: const EdgeInsets.all(2),
      content: SizedBox(
        height: 280,
        width: 100,
        child: MobileScanner(
          controller: controller,
          onDetect: (capture) {
            final List<Barcode> barcodes = capture.barcodes;
            for (final barcode in barcodes) {
              if (barcode.rawValue != null) {
                context
                    .read<ReceiptBloc>()
                    .add(ReceiptAddGoodByBarcodeEvent(barcode.rawValue));
              }
            }
          },
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.close),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              controller.toggleTorch();
            });
          },
          icon: ValueListenableBuilder(
            valueListenable: controller.torchState,
            builder: (context, state, child) {
              switch (state) {
                case TorchState.off:
                  return const Icon(
                    Icons.flash_off,
                  );
                case TorchState.on:
                  return const Icon(
                    Icons.flash_on,
                  );
              }
            },
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
