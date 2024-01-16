import 'package:http/http.dart' as http;
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nd_telemedicine/api/appointment_api.dart';
import '../../utilities/imports.dart';
import 'dart:convert';
import 'dart:io';

class BookingByTime extends StatefulWidget {
  final HealthStatus symptoms;
  const BookingByTime({Key? key, required this.symptoms}) : super(key: key);
  @override
  State<BookingByTime> createState() => _BookingByTime();
}

class _BookingByTime extends State<BookingByTime> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String? daySelected;

  var doctorIdToNames = [];
  final List<String> _doctors = ['Doctor'];
  late List<String> _dates = [];

  DateTime? selectedDate = DateTime.now();

  String doctorValue = 'Doctor';
  int doctorId = 0;
  String day = "";
  String time = "";

  String hourValue = 'Hour';

  @override
  void initState() {
    getDoctors();
    super.initState();
  }

  Future getDoctors() async {
    var response = await http.get(
        Uri.parse("$SERVERDOMAIN/user/get/users/doctor"),
        headers: {'Content-Type': 'application/json'});
    var doctors = jsonDecode(response.body);

    for (var doctor in doctors) {
      var id = doctor["id"];
      var name = "${doctor['firstName']} ${doctor['lastName']}";
      var responseDataName = {"id": id, "name": name};
      if (!_doctors.contains(responseDataName.toString())) {
        _doctors.add(name);
        doctorIdToNames.add({'doctor_id': id, 'Doctor_Name': name});
      }
    }
    setState(() {});
  }

  Widget times() {
    return CustomRadioButton(
      spacing: 50,
      buttonLables: _dates,
      buttonValues: _dates,
      radioButtonValue: (value) {
        setState(() {
          time = value as String;
        });
      },
      buttonTextStyle: ButtonTextStyle(
        selectedColor: Colors.black,
        unSelectedColor: Theme.of(context).cardColor,
      ),
      enableButtonWrap: true,
      elevation: 2,
      autoWidth: true,
      enableShape: true,
      unSelectedBorderColor: AppColors.secondary,
      selectedBorderColor: AppColors.secondaryAccent,
      unSelectedColor: AppColors.secondary,
      selectedColor: AppColors.secondaryAccent,
      padding: 5,
      shapeRadius: 10,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const AppBarItem(
          icon: CupertinoIcons.home,
          index: 3,
        ),
        title: const Text("Book Appointment",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            )),
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: DateCalendar(
                focusDate: selectedDate,
                onDateChange: (newDate) async {
                  // Perform the asynchronous operation outside setState
                  if (doctorValue == 'Doctor') {
                    alert("Select a doctor", context);
                    doctorId = 0;
                  } else {
                    doctorId = 0;

                    for (var element in doctorIdToNames) {
                      if (element['Doctor_Name'] == doctorValue) {
                        doctorId = element['doctor_id'];
                      }
                    }

                    List<String> availabilityDates =
                        await AppointmentService.checkAvailability(
                            doctorId, newDate!);
                    // Update the state inside setState
                    setState(() {
                      selectedDate = newDate;
                      time = "";
                      _dates.clear();
                      _dates.addAll(availabilityDates);
                    });
                  }
                },
              ),
            ),
            const Divider(
              height: 32,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: times(),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20.0, top: 20),
              child: Text(
                'Select Doctor',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 20),
              child: Container(
                width: MediaQuery.of(context).size.width * 1,
                //alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                    color: AppColors.cardLight,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 3,
                          offset: Offset(0, 1))
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
          ],
        ),
      ),
      bottomNavigationBar: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(40, 0, 30, 50),
          child: SubmitButton(
            color: AppColors.secondary,
            message: "Submit",
            width: MediaQuery.of(context).size.width,
            height: 60,
            onPressed: () async {
              http.Response response = await AppointmentService.bookAppointment(
                  doctorId, selectedDate!, time, widget.symptoms);
              if (response.statusCode == 200) {
                navigate(const HomePage(), context);
                // saveAppointment(doctorId, selectedDate!, time);
              } else {
                alert("Booking Appointment Failed", context);
              }
            },
          )),
    );
  }
}

class DateCalendar extends StatefulWidget {
  final DateTime? focusDate;
  final ValueChanged<DateTime?> onDateChange;

  @override
  DateCalendar({Key? key, required this.focusDate, required this.onDateChange})
      : super(key: key);

  @override
  State<DateCalendar> createState() => _DateCalendar();
}

class _DateCalendar extends State<DateCalendar> {
  final EasyInfiniteDateTimelineController _controller =
      EasyInfiniteDateTimelineController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EasyInfiniteDateTimeLine(
          activeColor: AppColors.secondary,
          controller: _controller,
          firstDate: DateTime.now(),
          focusDate: widget.focusDate,
          lastDate: DateTime.now().add(const Duration(days: 60)),
          onDateChange: (selectedDate) {
            setState(() {
              widget.onDateChange(selectedDate);
            });
          },
        ),
      ],
    );
  }
}
