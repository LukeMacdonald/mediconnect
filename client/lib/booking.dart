import 'dart:convert';

import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'user.dart';
import 'booking_by_time.dart';
import 'package:flutter/material.dart';

class Booking extends StatefulWidget {
  const Booking({Key? key}) : super(key: key);

  @override
  _Booking createState() => _Booking();
}

class _Booking extends State<Booking> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  String url = "http://localhost:8080/booking";
  //Not sure if url needed

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.blue,
        body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 1.1,
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 1.2,
                    minHeight: MediaQuery.of(context).size.height * 1),
                decoration: const BoxDecoration(
                  color: Color(0xFF14181B),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('images/background.jpeg'),
                  ),
                ),
                child: Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      color: Color(0x990F1113),
                    ),
                    child: SingleChildScrollView(
                        child:
                            Column(mainAxisSize: MainAxisSize.max, children: [
                      const Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: Text(
                          'Book Appointment',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontSize: 50,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                          child: Container(
                              width: 700,
                              height: 700,
                              decoration: BoxDecoration(
                                color: const Color(0x66FFFFFF),
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 4,
                                    color: Color(0x33000000),
                                    offset: Offset(0, 2),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: SingleChildScrollView(
                                  child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 50, 0, 0),
                                      child: Container(
                                        width: 200,
                                        height: 200,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: const [
                                              BoxShadow(
                                                  color: Colors.black26,
                                                  blurRadius: 6,
                                                  offset: Offset(0, 2))
                                            ]),
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        BookingByTime())); // Add user to the parameters of Booking()
                                          },
                                          child: Column(
                                            children: const <Widget>[
                                              Icon(Icons.calendar_today_rounded,
                                                  size: 170,
                                                  color: Colors.black),
                                              Text(
                                                "By Time",
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 200, 0, 0),
                                      child: Container(
                                        width: 200,
                                        height: 200,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: const [
                                              BoxShadow(
                                                  color: Colors.black26,
                                                  blurRadius: 6,
                                                  offset: Offset(0, 2))
                                            ]),
                                        child: TextButton(
                                          onPressed: null,
                                          // Navigate to upcoming appointment page (TO DO LATER)
                                          child: Column(
                                            children: const <Widget>[
                                              Icon(Icons.person_rounded,
                                                  size: 170,
                                                  color: Colors.black),
                                              Text(
                                                "By Doctor",
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ]))))
                    ]))))));
  }
}