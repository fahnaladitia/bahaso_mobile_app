// ignore_for_file: unused_element

import 'package:bahaso_mobile_app/presentation/components/components.dart';
import 'package:flutter/material.dart';

Future<bool?> showLogoutConfirmationDialog(BuildContext context) async {
  return showDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Logout Confirmation',
    barrierColor: Colors.black.withOpacity(0.5),
    builder: (context) => const _LogoutConfirmationDialog(),
  );
}

class _LogoutConfirmationDialog extends StatelessWidget {
  const _LogoutConfirmationDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      title: const Text('Logout Confirmation'),
      content: const Text('Are you sure you want to logout?'),
      actions: [
        BasicButton.secondary(
          text: 'Cancel',
          onPressed: () => Navigator.of(context).pop(false),
        ),
        BasicButton.primary(
          text: 'Logout',
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ],
    );
  }
}
