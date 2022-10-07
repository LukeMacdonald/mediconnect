import 'dart:convert';
import '../../utilities/custom_functions.dart';
import '../../utilities/imports.dart';

import 'package:google_fonts/google_fonts.dart';
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

  Future set() async {
    await UserSecureStorage.getID().then((value) => id = value!);
    await UserSecureStorage.getJWTToken().then((value) => token = value!);
    getAvailability();
    splitString();
  }

  String? daySelected;
  TextEditingController dateInput = TextEditingController();

  @override
  void initState() {
    dateInput.text = ""; //set the initial value of text field
    set();
    super.initState();
  }

  final List<Map> _booking = [];
  final List<Map> doctorIdToNames = [];
  final List<String> _doctors = ['Doctor'];
  int? doctorId;
  List<String> details = [];

  void splitString() {
    details = widget.appointmentDetails.split(" | ");
  }

  Future getAvailability() async {
    final response =
        await http.get(Uri.parse("${availabilityIP}get/all/availabilities"));
    var responseData = json.decode(response.body);
    String day = "";

    for (var availability in responseData) {
      day = getDayStringFrontDayInt(availability["day_of_week"]);
      // Provided the doctor has gone through the dashboard, we simply take the doctor_id from their current availabilities
      doctorId = availability["_doctor_id"];

      String time =
          createTime(availability["_start_time"], availability["_end_time"]);

      final responseName =
          await http.get(Uri.parse("${authenticationIP}get/name/${doctorId}"));
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
          'id': details[3],
          'patient': int.parse(id),
          'doctor': doctorId,
          'date': date,
          'time': startTime,
          'today': DateFormat("HH:mm:ss").format(DateTime.now()).toString()
        }));
    if (!mounted) return;
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
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

  Widget updateBooking() {
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
                  minWidth: 800, maxWidth: 800, minHeight: 400, maxHeight: 400),
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
                  Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.fromLTRB(80, 15, 0, 0),
                          child: Column(
                            children: [
                              Text(
                                "Original Appointment Details: ",
                                style: GoogleFonts.lexendDeca(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                child: Text("Doctor: Dr.${details[0]}"),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                child: Text("Date: ${details[1]}"),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                child: Text("Time: ${details[2]}"),
                              ),
                            ],
                          )),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(80, 15, 0, 0),
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
                            padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
                            child: Text(
                              details[0],
                            ),
                            // Initial Value
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(80, 10, 0, 0),
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
                              child: Center(
                                  child: TextField(
                                      controller: dateInput,
                                      decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding:
                                              EdgeInsets.only(top: 15),
                                          prefixIcon:
                                              Icon(Icons.calendar_today),
                                          hintText: 'Date of Appointment',
                                          hintStyle:
                                              TextStyle(color: Colors.black)),
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
                                              DatePickerEntryMode.calendarOnly,
                                        );

                                        if (pickedDate != null) {
                                          String formattedDate =
                                              DateFormat('yyyy-MM-dd').format(
                                                  pickedDate); // Note that backend needs this format for string to be converted!!
                                          setState(() {
                                            dateInput.text = formattedDate;
                                            daySelected = DateFormat('EEEE')
                                                .format(pickedDate);
                                            // Will be converted in backend
                                          });
                                          // user.dob = dateInput.text;

                                        }
                                      })))),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(80, 10, 0, 0),
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
                            padding: const EdgeInsets.fromLTRB(20, 5, 0, 20),
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
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              80, 15, 0, 0),
                          child: ElevatedButton(
                            onPressed: () {
                              //TODO: functions on backend
                              if (dateInput.text == "") {
                                alert("Provide a date");
                              } else if (hourValue == 'Hour') {
                                alert("Select a hour range");
                              } else {
                                if ((_booking.any((element) => mapEquals(
                                            element, {
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
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              padding: const EdgeInsets.all(20),
                              primary: const Color.fromARGB(255, 129, 125, 125),
                              onPrimary: Colors.black,
                            ),
                            child: Text('Confirm',
                                style: GoogleFonts.lexendDeca(
                                  textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                )),
                          )),
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
                Text('Update Appointment',
                    style: GoogleFonts.roboto(
                      textStyle:
                          const TextStyle(color: Colors.white, fontSize: 40),
                    )),
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
