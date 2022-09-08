import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'user.dart';

//TODO: Dynamically add textfields
class SetAvailability extends StatefulWidget {
  const SetAvailability({Key? key}) : super(key: key);

  @override
  State<SetAvailability> createState() => _SetAvailability();
}

class _SetAvailability extends State<SetAvailability> {
  User user = User("", "", "");
  // TextEditingController dateInput = TextEditingController();
  String url = "http://localhost:8080/set_availability";

  // Change this for connection to backend
  Future save() async {
    await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': user.email,
          'password': user.password,
          'role': user.role
        }));
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  Widget availabilityList() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 10),
          Container(
              constraints: const BoxConstraints(
                  minWidth: 800, maxWidth: 800, minHeight: 300, maxHeight: 300),
              decoration: BoxDecoration(
                  color: const Color(0x86C6F7FD),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(0, 2))
                  ]),
              height: 60,
              // TODO: add a list of the set availibility (list_view)
              child: Text(
                  '    List of Each Day of the Week and the option to select what hours the doctor is available to work',
                  style: GoogleFonts.lexendDeca(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  )))
        ]);
  }

  Widget setting() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[const SizedBox(height: 10), Container()]);
  }

  Widget availability() {
    return SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(children: [
          const Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 0)),
          availabilityList(),
          Align(
              alignment: const AlignmentDirectional(-0.57, 0.05),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                child: Text('Specific Dates Not Available',
                    style: GoogleFonts.lexendDeca(
                        textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ))),
              )),
          Container(
              constraints: const BoxConstraints(minWidth: 800, maxWidth: 800),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(0, 2))
                  ]),
              height: 200,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Container(
                          constraints: const BoxConstraints(
                              minWidth: 100, maxWidth: 200),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: const Color(0x86C6F7FD),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 6,
                                    offset: Offset(0, 2))
                              ]),
                          height: 60,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 0, 20),
                            child: TextFormField(
                              // keyboardType: TextInputType.name,
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(top: 15),
                                  hintText: 'Day',
                                  hintStyle: TextStyle(color: Colors.black)),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Container(
                          constraints: const BoxConstraints(
                              minWidth: 100, maxWidth: 200),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: const Color(0x86C6F7FD),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 6,
                                    offset: Offset(0, 2))
                              ]),
                          height: 60,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 0, 20),
                            child: TextFormField(
                              // keyboardType: TextInputType.name,
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(top: 15),
                                  hintText: 'Hour',
                                  hintStyle: TextStyle(color: Colors.black)),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          child: Container(
                              child: ElevatedButton(
                            onPressed: () {},
                            child: Icon(Icons.add, color: Colors.white),
                            style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(20),
                              primary: Colors.grey,
                              onPrimary: Colors.black,
                            ),
                          ))),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(80, 0, 0, 0),
                        child: Container(
                          constraints: const BoxConstraints(
                              minWidth: 200, maxWidth: 200),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.calendar_today_rounded,
                              color: Colors.black, size: 200),
                        ),
                      ),
                    ],
                  )
                ],
              ))
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        body: Container(
            height: MediaQuery.of(context).size.height * 1,
            decoration: BoxDecoration(
                color: const Color(0xFF14181B),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: const AssetImage('images/background.jpeg'),
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.5), BlendMode.darken))),
            child: SingleChildScrollView(
                child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    width: double.infinity,
                    height: 20,
                    decoration: const BoxDecoration(color: Colors.transparent)),
                Text('Set Availability',
                    style: GoogleFonts.roboto(
                      textStyle:
                          const TextStyle(color: Colors.white, fontSize: 60),
                    )),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                  child: Container(
                      //height: MediaQuery.of(context).size.height * 1,
                      constraints:
                          const BoxConstraints(minWidth: 700, minHeight: 580),
                      decoration: const BoxDecoration(color: Color(0x00FFFFFF)),
                      child: availability()),
                ),
              ],
            ))));
  }
}
