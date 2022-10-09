import 'package:flutter/material.dart';
import 'package:nd_telemedicine/pages/profiles/remove_profile.dart';
import 'package:page_transition/page_transition.dart';

import '../utilities/custom_functions.dart';

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

Future<String?> deleteAccount(String email,String role, BuildContext context) {
  return showDialog<String>(
      context: context,
      builder: (BuildContext context) =>
          AlertDialog(content: const Text("Are you sure you want to remove account?"), actions: <Widget>[
            TextButton(
              onPressed: () async {
                await deleteProfile(email);
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        child: RemoveProfile(role: role)));
              },
              child: const Text('Confirm'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'Cancel');
              },
              child: const Text('Cancel'),
            ),
          ]));
}
