import 'package:flutter/material.dart';
import 'package:nd_telemedicine/utilities/imports.dart';
import 'dart:io' show Platform;

String? authenticationIP;
String? availabilityIP;
String? communicationIP;
String? appointmentIP;
String? medicationIP;
String? messageIP;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      authenticationIP = "http://10.0.2.2:8080/";
      availabilityIP = "http://10.0.2.2:8081/";
      communicationIP = "http://10.0.2.2:8082/";
      appointmentIP = "http://10.0.2.2:8083/";
      medicationIP = "http://10.0.2.2:8084";
      messageIP = "http://10.0.2.2:8085/";
    } else {
      authenticationIP = "http://localhost:8080/";
      availabilityIP = "http://localhost:8081/";
      communicationIP = "http://localhost:8082/";
      appointmentIP = "http://localhost:8083/";
      medicationIP = "http://10.0.2.2:8084";
      messageIP = "http://localhost:8085/";
    }

    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: MaterialApp(
          theme: AppTheme().dark,
          themeMode: ThemeMode.dark,
          title: 'ND Telemedicine',
          debugShowCheckedModeBanner: false,
          home: const Landing(),
        ));
  }
}
