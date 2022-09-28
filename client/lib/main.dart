import 'package:flutter/material.dart';
import 'package:nd_telemedicine/pages/landing.dart';
import 'package:nd_telemedicine/styles/theme.dart';

const authenticationIP = "http://localhost:8080/";
const availabilityIP = "http://localhost:8081/";
const appointmentIP = "http://localhost:8083/";
const communicationIP = "http://localhost:8082/";
const messageIP = "http://localhost:8085/";

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

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
    )
    );
  }
}
