import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  final Function onChanged;
  final String label;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final String? errorText;
  final bool obscureText;
  final EdgeInsets? padding;

  const InputWidget({
    super.key,
    required this.onChanged,
    required this.label,
    this.prefixIcon,
    this.suffixIcon,
    this.errorText,
    this.obscureText = false,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) => onChanged(value),
      obscureText: obscureText,
      decoration: InputDecoration(
        contentPadding: padding,
        border: const OutlineInputBorder(),
        hintText: label,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        errorText: errorText,
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}
