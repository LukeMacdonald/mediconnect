import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nd_telemedicine/pages/landing.dart';
import 'package:nd_telemedicine/security/storage_service.dart';
import 'package:nd_telemedicine/styles/theme.dart';

import 'models/user.dart';

const authenticationIP = "http://localhost:8080/";
const availabilityIP = "http://localhost:8081/";
const communicationIP = "http://localhost:8082/";
const appointmentIP = "http://localhost:8083/";
const messageIP = "http://localhost:8085/";

const storage = FlutterSecureStorage();

//UserSecureStorage user = UserSecureStorage();


//User user = User();

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
