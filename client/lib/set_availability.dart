import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import 'user.dart';

class SetAvailability extends StatefulWidget {
  const SetAvailability({Key? key}) : super(key: key);

  @override
  State<SetAvailability> createState() => _SetAvailability();
}

class _SetAvailability extends State<SetAvailability> {
  User user = User("", "", "");
  // TextEditingController dateInput = TextEditingController();
  String url = "http://localhost:8080/SetDoctorAvailability";
  String url2 = "http://localhost:8080/GetAllDoctorAvailability";
  int? doctorId;

  Future save() async {
    int? day;
    switch (dayValue) {
      case "Monday":
        day = 1;
        break;
      case 'Tuesday':
        day = 2;
        break;
      case 'Wednesday':
        day = 3;
        break;
      case 'Thursday':
        day = 4;
        break;
      case 'Friday':
        day = 5;
        break;
      case 'Saturday':
        day = 6;
        break;
    }
    await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'doctor_id': doctorId,
          'day_of_week': day,
          'start_time': hourValue.substring(0, 5),
          'end_time': hourValue.substring(
            8,
          )
        }));
  }

  final List<Map> _availability = [];
  @override
  void initState() {
    super.initState();
    getAvailability();
  }

  Future getAvailability() async {
    final response = await http.get(Uri.parse(url2));
    var responseData = json.decode(response.body);
    String day = "";

    for (var availability in responseData) {
      switch (availability["day_of_week"]) {
        case 1:
          day = 'Monday';
          break;
        case 2:
          day = 'Tuesday';
          break;
        case 3:
          day = 'Wednesday';
          break;
        case 4:
          day = 'Thursday';
          break;
        case 5:
          day = 'Friday';
          break;
        case 6:
          day = 'Saturday';
          break;
      }
      // Provided the doctor has gone through the dashboard, we simply take the doctor_id from their current availabilities
      doctorId = availability["_doctor_id"];
      String time = availability["_start_time"]
              .substring(0, availability["_start_time"].length - 3) +
          " - " +
          availability["_end_time"]
              .substring(0, availability["_end_time"].length - 3);
      _availability.add({'Day': day, 'Hour': time});
    }
  }
  String dayValue = 'Day';
  String hourValue = 'Hour';
  final _days = [
    'Day',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];
  // Change the type if necessary
  final _hours = [
    'Hour',
    '09:00 - 10:00',
    '10:00 - 11:00',
    '11:00 - 12:00',
    '12:00 - 13:00',
    '13:00 - 14:00',
    '14:00 - 15:00',
    '15:00 - 16:00',
    '16:00 - 17:00'
  ];

  Future<String?> alert(String message) {
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
              // LISTVIEW
              child: SizedBox(height: 200, child: _createTable()))
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
              alignment: const AlignmentDirectional(-0.35, 0.05),
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
                            child: DropdownButtonFormField(
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 15),
                              ),
                              // Initial Value
                              value: dayValue,

                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),

                              // Array list of items
                              items: _days.map((String days) {
                                return DropdownMenuItem(
                                  value: days,
                                  child: Text(days),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (value) {
                                dayValue = value.toString();
                              },
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
                            child: DropdownButtonFormField(
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 15),
                              ),
                              // Initial Value
                              value: hourValue,

                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),

                              // Array list of items
                              items: _hours.map((String hours) {
                                return DropdownMenuItem(
                                  value: hours,
                                  child: Text(hours),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (value) {
                                hourValue = value.toString();
                              },
                            ),
                          ),
                        ),
                      ),
                      Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          child: ElevatedButton(
                            onPressed: () {
                          if (dayValue == 'Day') {
                            {
                              alert('Please Enter A Day');
                            }
                          } else if (hourValue == 'Hour') {
                            {
                              alert('Please Enter A Time');
                            }
                          } else {
                            {
                              // Map Equality comparison to dynamically compare the keys and its current values to compare to what exists
                              if (_availability.any((element) =>
                                  mapEquals(element, {
                                    'Day': dayValue,
                                    'Hour': hourValue
                                  }))) {
                                alert('Invalid Availability');
                              } else {
                                alert('Valid Availability');
                                setState(() {
                                  _availability.add(
                                      {'Day': dayValue, 'Hour': hourValue});
                                });

                                // Save the availability
                                save();
                              }

                            }
                          }
                            },
                            style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(20),
                          primary: const Color.fromARGB(255, 129, 125, 125),
                          onPrimary: Colors.black,
                            ),
                            child: const Icon(Icons.add, color: Colors.white),
                          )),
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
  Widget _createTable() {
    return SingleChildScrollView(
        child: DataTable(columns: _createColumns(), rows: _createRows()));
  }

  List<DataColumn> _createColumns() {
    return [
      const DataColumn(label: Text('Day')),
      const DataColumn(label: Text('Time Range'))
    ];
  }

  List<DataRow> _createRows() {
    return _availability
        .map((map) => DataRow(
            cells: [DataCell(Text(map['Day'])), DataCell(Text(map['Hour']))]))
        .toList();
  }
}
