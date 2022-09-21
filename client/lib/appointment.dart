import 'booking.dart';
import 'utilities/user.dart';
import 'booking_by_time.dart';

import 'package:google_fonts/google_fonts.dart';
import 'utilities/dashboard_utils.dart';
import 'package:flutter/material.dart';

class Appointment extends StatefulWidget {
  final User user;
  const Appointment({Key? key, required this.user}) : super(key: key);

  @override
  _Appointment createState() => _Appointment(user);
}

class _Appointment extends State<Appointment> {
  _Appointment(this.user);
  User user;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  String url = "http://localhost:8080/appointment";

  //TODO: Change this dart file for upcoming appointment
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
                          'Appointment',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontSize: 50,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SingleChildScrollView(
                          child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                            menuButtons(
                                Color.fromARGB(255, 82, 80, 80),
                                const Text(
                                  'Book Appointment',
                                ),
                                const Icon(Icons.calendar_today_rounded,
                                    size: 15),
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        BookingByTime(user: user))),
                            menuButtons(
                                Color.fromARGB(255, 82, 80, 80),
                                const Text(
                                  'Upcoming Appointment',
                                ),
                                const Icon(Icons.calendar_today_rounded,
                                    size: 15),
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Appointment(user: user),
                                ))
                          ]))
                    ]))))));
  }
}
