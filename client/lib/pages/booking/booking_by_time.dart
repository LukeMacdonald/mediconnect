import 'dart:io';

import 'package:page_transition/page_transition.dart';
import '../../utilities/custom_functions.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../utilities/imports.dart';
import 'dart:convert';

class BookingByTime extends StatefulWidget {

  const BookingByTime({Key? key}) : super(key: key);

  @override
  State<BookingByTime> createState() => _BookingByTime();
}

class _BookingByTime extends State<BookingByTime> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String? daySelected;
  TextEditingController dateInput = TextEditingController();
  final List<Map> _booking = [];
  final List<Map> doctorIdToNames = [];
  final List<String> _doctors = ['Doctor'];

  String doctorValue = 'Doctor';
  int? doctorId;
  String day = "";

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


  @override
  void initState() {
    dateInput.text = "";
    //set the initial value of text field
    getAvailability();
    super.initState();

  }
  Future getAvailability() async {
    User user = User();
    await user.transferDetails();

    final response = await http.get(
      Uri.parse("${availabilityIP}get/all/availabilities"),
      headers: {'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: "Bearer ${user.accessToken}"},);
    var responseData = json.decode(response.body);


    for (var availability in responseData) {
      day = getDayStringFrontDayInt(availability["day_of_week"]);
      // Provided the doctor has gone through the dashboard, we simply take the doctor_id from their current availabilities
      doctorId = availability["_doctor_id"];

      String time = availability["_start_time"] + " - " + availability["_end_time"];

      final responseName = await http
          .get(Uri.parse("${authenticationIP}get/name/$doctorId"));
      var responseDataName = responseName.body;
      _booking.add(
          {'Doctor': responseDataName.toString(), 'Day': day, 'Hour': time});
      if (!_doctors.contains(responseDataName.toString())) {
        _doctors.add(responseDataName.toString());
        doctorIdToNames.add({
          'doctor_id': doctorId,
          'Doctor_Name': responseDataName.toString()
        });
      }
    }
    setState(() {});
  }

  Widget bookingList() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 10),
          Container(
              constraints: const BoxConstraints(
                  minWidth: 800, maxWidth: 800, minHeight: 300, maxHeight: 300),
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
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

  Widget bookingByTime() {
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
              constraints: const BoxConstraints(
                  minWidth: 800, maxWidth: 800, minHeight: 300, maxHeight: 300),
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(0, 2))
                  ]),
              height: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                    child: Container(
                      constraints:
                          const BoxConstraints(minWidth: 100, maxWidth: 250),
                      //alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black26,
                                blurRadius: 6,
                                offset: Offset(0, 2))
                          ]),
                      height: 60,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 10, 20),
                        child: DropdownButtonFormField(
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(top: 10),
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
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Container(
                          constraints: const BoxConstraints(
                              minWidth: 100, maxWidth: 250),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: AppColors.secondary,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 6,
                                    offset: Offset(0, 2))
                              ]),
                          height: 60,
                          child: TextField(
                              controller: dateInput,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding:
                                      const EdgeInsets.only(top: 15, left: 20),
                                  suffixIcon: const Icon(Icons.calendar_today),
                                  hintText: 'Date of Appointment',
                                  hintStyle:
                                      Theme.of(context).textTheme.titleMedium),
                              readOnly: true,
                              // set it true, user cannot edit text
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2030),
                                  // selectableDayPredicate: (DateTime datetime) {
                                  //   if (datetime.weekday == DateTime.sunday) {
                                  //     return false;
                                  //   }
                                  //   return true;
                                  // },
                                  initialEntryMode:
                                      DatePickerEntryMode.calendarOnly,
                                );

                                if (pickedDate != null) {
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd').format(
                                          pickedDate); // Note that backend needs this format for string to be converted!!
                                  setState(() {
                                    dateInput.text = formattedDate;
                                    daySelected =
                                        DateFormat('EEEE').format(pickedDate);
                                    // Will be converted in backend
                                  });
                                  // user.dob = dateInput.text;

                                }
                              }))),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Container(
                      constraints:
                          const BoxConstraints(minWidth: 100, maxWidth: 250),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black26,
                                blurRadius: 6,
                                offset: Offset(0, 2))
                          ]),
                      height: 60,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 10, 20),
                        child: DropdownButtonFormField(
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(top: 10),
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
                          const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                      child: SubmitButton(
                        color: Colors.teal,
                        message: "Submit",
                        width: 225,
                        height: 50,
                        onPressed: () {
                          if (doctorValue == 'Doctor') {
                            alert("Select a doctor",context);
                          } else if (dateInput.text == "") {
                            alert("Provide a date",context);
                          } else if (hourValue == 'Hour') {
                            alert("Select a hour range",context);
                          } else {
                            if ((_booking.any((element) => mapEquals(element, {
                                      'Doctor': doctorValue,
                                      'Day': daySelected,
                                      'Hour': hourValue
                                    }))) &&
                                (DateTime.now().isBefore(DateTime.parse(
                                    "${dateInput.text} ${hourValue.substring(0, 5)}")))) {
                              // Boolean Function to check whether it exists
                              // If true then valid and proceed with save() call
                              // Else, place an alert about appointment is already filled by the doctor
                              int id = 0;
                              for (var element in doctorIdToNames) {
                                if (element['Doctor_Name'] == doctorValue) {
                                  id = element['doctor_id'];
                                }
                              }
                              if (id == 0) {
                                alert('Invalid Doctor ID',context);
                              } else {
                                checkAppointment(id, dateInput.text,
                                    hourValue.substring(0, 5),context);
                              }
                            } else {
                              alert('Invalid Booking Appointment',context);
                            }
                          }
                        },
                      )),
                ],
              ))
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: const AppBarItem(
            icon: CupertinoIcons.home,
            index: 0,
          ),
          title: const Text("Book Appointment",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              )),
          actions: const <Widget>[
            AppBarItem(
              icon: CupertinoIcons.bell_fill,
              index: 5,

            ),
            SizedBox(width: 20),
            AppBarItem(
              icon: CupertinoIcons.settings_solid,
              index: 5,
            ),
            SizedBox(width: 20),
          ],
        ),
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20.0, top: 10),
              child: Text(
                'Select Date and Time',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                  child: Container(
                      //height: MediaQuery.of(context).size.height * 1,
                      constraints:
                          const BoxConstraints(minWidth: 700, minHeight: 580),
                      decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
                      child: bookingByTime()),
                ),
              ],
            ),
          ],
        )));
  }

  Widget _createTable() {
    return SingleChildScrollView(
        child: DataTable(columns: _createColumns(), rows: _createRows(),columnSpacing: 20,));
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
