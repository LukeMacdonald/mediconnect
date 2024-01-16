// import 'package:nd_telemedicine/utilities/imports.dart';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:nd_telemedicine/pages/landing.dart';
import 'package:nd_telemedicine/styles/theme.dart';

String? SERVERDOMAIN;
String? availabilityIP;
String? communicationIP;
String? appointmentIP;
String? medicationIP;
String? messageIP;
String? prescriptionIP;

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    SERVERDOMAIN = Platform.isAndroid ? "http://10.0.2.2:8060" : "http://localhost:8060";

    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: MaterialApp(
          theme: AppTheme().light,
          darkTheme: AppTheme().dark,
          themeMode: ThemeMode.light,
          title: 'ND Telemedicine',
          debugShowCheckedModeBanner: false,
          home: const Landing(),
    )
    );
  }
}
