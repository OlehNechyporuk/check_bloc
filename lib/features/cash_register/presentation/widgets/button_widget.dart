import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String label;
  final Function()? onPressed;

  const ButtonWidget({super.key, this.onPressed, required this.label});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        padding: const MaterialStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 30),
        ),
        minimumSize: const MaterialStatePropertyAll(Size(double.infinity, 60)),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}
