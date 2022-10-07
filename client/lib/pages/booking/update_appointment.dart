import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';

import '../../utilities/custom_functions.dart';
import '../../utilities/imports.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';

class UpdateAppointment extends StatefulWidget {
  final String appointmentDetails;
  const UpdateAppointment({Key? key, required this.appointmentDetails})
      : super(key: key);

  @override
  State<UpdateAppointment> createState() => _UpdateAppointment();
}

class _UpdateAppointment extends State<UpdateAppointment> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String token = "";
  String id = "";
  final List<Map> _booking = [];
  final List<Map> doctorIdToNames = [];
  final List<String> _doctors = ['Doctor'];
  int? doctorId;
  List<String> details = [];
  String? daySelected;
  TextEditingController dateInput = TextEditingController();

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

  Future set() async {
    await UserSecureStorage.getID().then((value) => id = value!);
    await UserSecureStorage.getJWTToken().then((value) => token = value!);
    getAvailability();
  }

  void splitString() {
    details = widget.appointmentDetails.split(" | ");
  }

  @override
  void initState() {
    dateInput.text = "";
    set();
    splitString();
    super.initState();
  }

  Future getAvailability() async {
    final response = await http.get(
      Uri.parse("${availabilityIP}get/all/availabilities"),
      headers: {
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: "Bearer $token"
      },
    );
    var responseData = json.decode(response.body);
    String day = "";

    for (var availability in responseData) {
      day = getDayStringFrontDayInt(availability["day_of_week"]);
      // Provided the doctor has gone through the dashboard, we simply take the doctor_id from their current availabilities
      doctorId = availability["_doctor_id"];
      String time =
          availability["_start_time"] + " - " + availability["_end_time"];
      final responseName =
          await http.get(Uri.parse("${authenticationIP}get/name/$doctorId"));
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

  Future save(int doctorId, String date, String startTime) async {
    await http.put(Uri.parse("${appointmentIP}update/appointment"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'id': int.parse(details[3]),
          'patient': int.parse(id),
          'doctor': doctorId,
          'date': date,
          'time': startTime,
          'today': DateFormat("HH:mm:ss").format(DateTime.now()).toString()
        }));
    if (!mounted) return;
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
  }

  Future checkAppointment(int id, String date, String startTime) async {
    final response = await http.get(
        Uri.parse("${appointmentIP}search/appointment/$id/$date/$startTime"));
    var responseData = response.body;
    if (responseData == 'false') {
      alert("Succesfully Updated the Appointment!!");
      save(id, date, startTime);
    } else {
      alert(
          "An appointment has already been made for this doctor on date selected");
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Align(
            alignment: Alignment.centerRight,
            child: IconBackground(
              icon: CupertinoIcons.back,
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          title: const Text("Set Availability",
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
            AppDropDown(),
          ],
        ),
        body: SingleChildScrollView(
            child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                width: double.infinity,
                height: 20,
                decoration: const BoxDecoration(color: Colors.transparent)),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
              child: Container(
                  //height: MediaQuery.of(context).size.height * 1,
                  constraints:
                      const BoxConstraints(minWidth: 700, minHeight: 580),
                  decoration: const BoxDecoration(color: Color(0x00FFFFFF)),
                  child: updateBooking()),
            ),
          ],
        )));
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

  Widget setting() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[const SizedBox(height: 10), Container()]);
  }

  Widget updateBooking() {
    return Column(children: [
      //const Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 0)),
      bookingList(),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: Container(
            constraints: const BoxConstraints(
                minWidth: 800, maxWidth: 800, minHeight: 400, maxHeight: 400),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(
                            "Original Appointment Details: ",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text("Doctor: Dr.${details[0]}"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text("Date: ${details[1]}"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text("Time: ${details[2]}"),
                        ),
                      ],
                    ),
                    Container(
                      width: 250,
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
                      child: Center(
                        child: Text(
                          details[0],
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    Container(
                        width: 250,
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
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: TextField(
                              controller: dateInput,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: const Icon(
                                    Icons.calendar_today,
                                    color: Colors.white,
                                  ),
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
                                  selectableDayPredicate: (DateTime datetime) {
                                    if (datetime.weekday == DateTime.sunday) {
                                      return false;
                                    }
                                    return true;
                                  },
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
                              }),
                        ))),
                    Container(
                      width: 250,
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
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                    SubmitButton(
                        color: Colors.teal,
                        message: "Submit",
                        width: 225,
                        height: 50,
                        onPressed: () {
                          if (dateInput.text == "") {
                            alert("Provide a date");
                          } else if (hourValue == 'Hour') {
                            alert("Select a hour range");
                          } else {
                            if ((_booking.any((element) => mapEquals(element, {
                                      'Doctor': details[0],
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
                                if (element['Doctor_Name'] == details[0]) {
                                  id = element['doctor_id'];
                                }
                              }
                              if (id == 0) {
                                alert('Invalid Doctor ID');
                              } else {
                                checkAppointment(id, dateInput.text,
                                    hourValue.substring(0, 5));
                              }
                            } else {
                              alert('Invalid Booking Appointment');
                            }
                          }
                        }),
                  ],
                )
              ],
            )),
      )
    ]);
  }

  Widget _createTable() {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
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
