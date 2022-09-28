import 'package:flutter/material.dart';

Future<String?> alert(String message, BuildContext context) {
  return showDialog<String>(
      context: context,
      builder: (BuildContext context) =>
          AlertDialog(content: Text(message), actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'OK');
              },
              child: const Text('OK'),
            ),
          ]));
}
