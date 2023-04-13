import 'package:flutter/material.dart';

showErrorSnakbar(String text) {
  return SnackBar(content: Text(text), backgroundColor: Colors.red);
}

showSuccessSnakbar(String text) {
  return SnackBar(content: Text(text), backgroundColor: Colors.green);
}

showInfoSnakbar(String text) {
  return SnackBar(content: Text(text), backgroundColor: Colors.blue);
}
