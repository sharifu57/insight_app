import 'package:flutter/material.dart';

class ErrorDialog {
  static void showErrorDialog(BuildContext context, String? message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Error',
              style: TextStyle(color: Colors.red),
            ),
            content: Text(message!),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
