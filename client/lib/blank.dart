import 'package:flutter/material.dart';

class Blank extends StatefulWidget {
  const Blank({Key? key}) : super(key: key);

  @override
  State<Blank> createState() => _Blank();
}

class _Blank extends State<Blank> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        body: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: const AssetImage('images/background.jpeg'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.5), BlendMode.darken))),
            )
        )
    );
  }
}