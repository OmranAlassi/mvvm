// lib/core/helpers/snack_bar_helper.dart
import 'package:flutter/material.dart';

abstract class AppSnackBar {
  static void showError(BuildContext context, String message) {
    _show(context, message, Colors.redAccent);
  }

  static void showSuccess(BuildContext context, String message) {
    _show(context, message, Colors.green);
  }

  static void _show(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: color,
          behavior: SnackBarBehavior.floating,
        ),
      );
  }
}