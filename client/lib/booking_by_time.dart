import 'dart:convert';

import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'user.dart';

import 'package:flutter/material.dart';

class BookingByTime extends StatefulWidget {
  const BookingByTime({Key? key}) : super(key: key);

  @override
  _BookingByTime createState() => _BookingByTime();
}

class _BookingByTime extends State<BookingByTime> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  String url = "http://localhost:8080/booking_by_time";
  //Not sure if url needed

  TextEditingController dateInput = TextEditingController();

  @override
  void initState() {
    dateInput.text = ""; //set the initial value of text field
    super.initState();
    getAvailability();
    //print(_booking);
  }

  final List<Map> _booking = [];
  final List<String> _doctors = ['Doctor'];
  String doctorValue = 'Doctor';
  int? doctorId;

  Future getAvailability() async {
    final response = await http
        .get(Uri.parse("http://localhost:8080/GetAllDoctorsAvailabilities"));
    var responseData = json.decode(response.body);
    print(response.body);
    String day = "";

    for (var availiability in responseData) {
      switch (availiability["day_of_week"]) {
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
      // Provided the doctor has gone through the dashboard, we simply take the doctor_id from their current availiabilities
      doctorId = availiability["_doctor_id"];
      String time = availiability["_start_time"]
              .substring(0, availiability["_start_time"].length - 3) +
          " - " +
          availiability["_end_time"]
              .substring(0, availiability["_end_time"].length - 3);

      final responseName = await http.get(Uri.parse(
          "http://localhost:8080/GetUserFullName/" + doctorId.toString()));
      var responseDataName = responseName.body;

      _booking.add(
          {'Doctor': responseDataName.toString(), 'Day': day, 'Hour': time});
      if (!_doctors.contains(responseDataName.toString())) {
        _doctors.add(responseDataName.toString());
      }
    }
    setState(() {});
  }

  final List<String> _hours = [
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
  String hourValue = 'Hour';

  Widget bookingList() {
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
              child: SizedBox(
                height: 200,
                child: _createTable(),
              ))
        ]);
  }

  Widget setting() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[const SizedBox(height: 10), Container()]);
  }

  Widget booking_by_time() {
    return SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(children: [
          const Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 0)),
          bookingList(),
          const Align(
              alignment: AlignmentDirectional(-0.35, 0.05),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
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
                        padding: const EdgeInsets.fromLTRB(80, 0, 0, 0),
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
                              value: doctorValue,

                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),

                              // Array list of items
                              items: _doctors.map((String doctors) {
                                return DropdownMenuItem(
                                  value: doctors,
                                  child: Text(doctors),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (value) {
                                doctorValue = value.toString();
                              },
                            ),
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Column(
                            children: [
                              Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 70, 0, 0),
                                  child: Container(
                                      constraints: const BoxConstraints(
                                          minWidth: 100, maxWidth: 200),
                                      alignment: Alignment.centerLeft,
                                      decoration: BoxDecoration(
                                          color: const Color(0x86C6F7FD),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: const [
                                            BoxShadow(
                                                color: Colors.black26,
                                                blurRadius: 6,
                                                offset: Offset(0, 2))
                                          ]),
                                      height: 60,
                                      child: Center(
                                          child: TextField(
                                              controller: dateInput,
                                              decoration: const InputDecoration(
                                                  border: InputBorder.none,
                                                  contentPadding:
                                                      EdgeInsets.only(top: 15),
                                                  prefixIcon: Icon(
                                                      Icons.calendar_today),
                                                  hintText:
                                                      'Date of Appointment',
                                                  hintStyle: TextStyle(
                                                      color: Colors.black)),
                                              readOnly: true,
                                              // set it true, user cannot edit text
                                              onTap: () async {
                                                DateTime? pickedDate =
                                                    await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime.now(),
                                                  lastDate: DateTime(2030),
                                                  selectableDayPredicate:
                                                      (DateTime datetime) {
                                                    if (datetime.weekday ==
                                                        DateTime.sunday) {
                                                      return false;
                                                    }
                                                    return true;
                                                  },
                                                  initialEntryMode:
                                                      DatePickerEntryMode
                                                          .calendarOnly,
                                                );

                                                if (pickedDate != null) {
                                                  String formattedDate =
                                                      DateFormat('yyyy-MM-dd')
                                                          .format(
                                                              pickedDate); // Note that backend needs this format for string to be converted!!
                                                  setState(() {
                                                    dateInput.text =
                                                        formattedDate;
                                                    // Will be converted in backend
                                                  });
                                                  // user.dob = dateInput.text;
                                                }
                                              })))),
                              Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 10, 0, 0),
                                  child: Container(
                                      child: ElevatedButton(
                                    onPressed: () {
                                      //TODO: functions on backend
                                    },
                                    child: Text('Confirm',
                                        style: GoogleFonts.lexendDeca(
                                          textStyle: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        )),
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      padding: EdgeInsets.all(20),
                                      primary: const Color.fromARGB(
                                          255, 129, 125, 125),
                                      onPrimary: Colors.black,
                                    ),
                                  ))),
                            ],
                          )),
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
                      //Button
                      // Padding(
                      //     padding:
                      //         const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      //     child: Container(
                      //         child: ElevatedButton(
                      //       onPressed: () {},
                      //       child: Icon(Icons.add, color: Colors.white),
                      //       style: ElevatedButton.styleFrom(
                      //         shape: const CircleBorder(),
                      //         padding: const EdgeInsets.all(20),
                      //         primary: const Color.fromARGB(255, 129, 125, 125),
                      //         onPrimary: Colors.black,
                      //       ),
                      //     ))),
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
                Text('Book Appointment By Time',
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
                      child: booking_by_time()),
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
      const DataColumn(label: Text('Doctor')),
      const DataColumn(label: Text('Day')),
      const DataColumn(label: Text('Time Range'))
    ];
  }

  List<DataRow> _createRows() {
    return _booking
        .map((map) => DataRow(cells: [
              DataCell(Text(map['Doctor'])),
              DataCell(Text(map['Day'])),
              DataCell(Text(map['Hour']))
            ]))
        .toList();
  }
}
