import 'package:flutter/material.dart';

extension ToasterExt on BuildContext {
  void showToastInfo(String message) {
    ScaffoldMessenger.of(this).clearSnackBars();
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        backgroundColor: Colors.grey.shade600,
        padding: const EdgeInsets.all(8.0),
        content: Row(
          children: [
            const Icon(
              Icons.info,
              color: Colors.white,
              size: 14,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                message,
                style: Theme.of(this).textTheme.bodyMedium?.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void showToastError(String message) {
    ScaffoldMessenger.of(this).clearSnackBars();
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        padding: const EdgeInsets.all(8.0),
        content: Row(
          children: [
            const Icon(
              Icons.error,
              color: Colors.white,
              size: 14,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                message,
                style: Theme.of(this).textTheme.bodyMedium?.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void showToastSuccess(String message) {
    ScaffoldMessenger.of(this).clearSnackBars();
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        padding: const EdgeInsets.all(8.0),
        content: Row(
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.white,
              size: 14,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                message,
                style: Theme.of(this).textTheme.bodyMedium?.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void showToastCustom(
    String message, {
    Color? backgroundColor,
    Widget? icon,
    Color? textColor,
  }) {
    ScaffoldMessenger.of(this).clearSnackBars();
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor ?? Colors.red,
        padding: const EdgeInsets.all(8.0),
        content: Row(
          children: [
            icon ?? const Icon(Icons.info, color: Colors.white, size: 14),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                message,
                style: Theme.of(this).textTheme.bodyMedium?.copyWith(color: textColor ?? Colors.white),
              ),
            ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
