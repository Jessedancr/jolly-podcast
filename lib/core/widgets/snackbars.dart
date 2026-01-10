import 'package:flutter/material.dart';

void _showScaffoldMessage(
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

void showSuccessfulScaffoldMessage(BuildContext context, String message) {
  _showScaffoldMessage(context, message, Colors.green);
}

void showFailureScaffoldMessage(BuildContext context, String message) {
  _showScaffoldMessage(context, message, Colors.red);
}
