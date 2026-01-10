import 'package:flutter/material.dart';

void _showSnackBar(
  BuildContext context,
  String message,
  Color backgroundColor,
) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message, style: const TextStyle(color: Colors.white)),
      backgroundColor: backgroundColor,
    ),
  );
}

void showSuccessSnackBar(BuildContext context, String message) {
  _showSnackBar(context, message, Colors.green);
}

void showErrorSnackBar(BuildContext context, String message) {
  _showSnackBar(context, message, Colors.red);
}
