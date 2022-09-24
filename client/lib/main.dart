import 'package:flutter/material.dart';
import 'pages/landing.dart';


const authenticationIP = "http://localhost:8080/";
const availabilityIP = "http://localhost:8081/";
const appointmentIP = "http://localhost:8081/";
const communicationIP = "http://localhost:8082/";
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);




  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'ND Telemedicine',
      debugShowCheckedModeBanner: false,
      home: Landing(),
    );
  }
}
