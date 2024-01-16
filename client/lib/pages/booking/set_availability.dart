import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interval_time_picker/interval_time_picker.dart';
import 'package:nd_telemedicine/api/availability-api.dart';
import '../../utilities/imports.dart';
import 'dart:convert';

extension TimeOfDayConverter on TimeOfDay {
  String to24hours() {
    final hour = this.hour.toString().padLeft(2, "0");
    final min = this.minute.toString().padLeft(2, "0");
    return "$hour:$min";
  }
}

class SetAvailability extends StatefulWidget {
  const SetAvailability({
    Key? key,
  }) : super(key: key);

  @override
  State<SetAvailability> createState() => _SetAvailability();
}

class _SetAvailability extends State<SetAvailability> {
  String token = "";
  String id = "";

  Future set() async {
    await UserSecureStorage.getID().then((value) => id = value!);
    await UserSecureStorage.getJWTToken().then((value) => token = value!);
    getAvailability();
  }

  Future save() async {
    int day = getDayIntFromDayString(dayValue);

    var response = await http.post(Uri.parse("$SERVERDOMAIN/availability/save"),
        headers: {
          'Content-Type': 'application/json',
          HttpHeaders.authorizationHeader: "Bearer $token"
        },
        body: json.encode({
          'doctorId': int.parse(id),
          'dayOfWeek': day,
          'startTime': _time.to24hours(),
          'endTime': _endTime.to24hours()
        }));
  }

  Future deleteAvailability(int index) async {
    List<String> availabilityTarget =
        _availability.elementAt(index).split(RegExp(r'\s*[|\\-]\s*'));

    var response =
        await http.delete(Uri.parse("$SERVERDOMAIN/availability/delete"),
            headers: {
              'Content-Type': 'application/json',
            },
            body: json.encode({
              'doctorId': int.parse(id),
              'dayOfWeek': getDayIntFromDayString(availabilityTarget[0]),
              'startTime': availabilityTarget[1],
              'endTime': availabilityTarget[2],
            }));
  }

  late List<String> _availability;

  @override
  void initState() {
    _availability = [];
    set();
    super.initState();
  }

  Future getAvailability() async {
    var responseData = await AvailabilityAPI.getAvailability(int.parse(id));

    String day = "";
    if (responseData != "" || responseData != null) {
      for (var availability in responseData) {
        day = getDayStringFrontDayInt(availability["dayOfWeek"]);
        String time = availability["startTime"]
                .substring(0, availability["startTime"].length) +
            " - " +
            availability["endTime"]
                .substring(0, availability["endTime"].length);

        _availability.add("$day  |  $time");

        setState(() {});
      }
    }
  }

  String dayValue = 'Day';

  final _days = [
    'Day',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
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

  TimeOfDay _time = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 9, minute: 0);
  final int _interval = 30;
  final VisibleStep _visibleStep = VisibleStep.thirtieths;

  void _selectStartTime() async {
    final TimeOfDay? newTime = await showIntervalTimePicker(
      context: context,
      initialTime: _time,
      interval: _interval,
      visibleStep: _visibleStep,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
      });
    }
  }

  void _selectEndTime() async {
    final TimeOfDay? newTime = await showIntervalTimePicker(
      context: context,
      initialTime: _endTime,
      interval: _interval,
      visibleStep: _visibleStep,
    );
    if (newTime != null) {
      setState(() {
        _endTime = newTime;
      });
    }
  }

  Widget availabilityList() {
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
              child: SizedBox(height: 200, child: _createListView()))
        ]);
  }

  Widget availability() {
    return SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(children: [
          const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0)),
          const Align(
            alignment: AlignmentDirectional(-1, 0.05),
            child: Text(
              'Availability List',
              style: TextStyle(fontSize: 20),
            ),
          ),
          availabilityList(),
          const Align(
              alignment: AlignmentDirectional(-1, 0.05),
              child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 10),
                  child: Text(
                    'Specific Dates Not Available',
                    style: TextStyle(fontSize: 20),
                  ))),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0, 2))
                    ]),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
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
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 0, 20),
                              child: DropdownButtonFormField(
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(top: 15),
                                ),
                                value: dayValue,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: _days.map((String days) {
                                  return DropdownMenuItem(
                                    value: days,
                                    child: Text(days),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  dayValue = value.toString();
                                },
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 10),
                          child: ElevatedButton(
                            onPressed: _selectStartTime,
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(
                                  MediaQuery.of(context).size.width * 0.6, 50),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            child: const Text('Select Start Time'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 10),
                          child: ElevatedButton(
                            onPressed: _selectEndTime,
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(
                                  MediaQuery.of(context).size.width * 0.6, 50),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            child: const Text('Select End Time'),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Start time: ${_time.format(context)}',
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'End time: ${_endTime.format(context)}',
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              00, 15, 0, 10),
                          child: GlowingActionButton(
                            color: AppColors.secondary,
                            icon: CupertinoIcons.add,
                            onPressed: () {
                              if (dayValue == 'Day') {
                                {
                                  alert('Please Enter A Day');
                                }
                              } else {
                                {
                                  var time =
                                      "${_time.to24hours()} - ${_endTime.to24hours()}";
                                  if (_availability
                                      .contains('$dayValue  |  $time')) {
                                    alert('Availability Already Set');
                                  } else {
                                    setState(() {
                                      _availability.add('$dayValue  |  $time');
                                      save();
                                    });
                                  }
                                }
                              }
                            },
                          ),
                          //
                        ),
                      ],
                    )
                  ],
                )),
          )
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
          index: 10,
        ),
        title: const Text("Set Availability",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            )),
      ),
      body: SingleChildScrollView(
          child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
            child: Container(
                constraints:
                    const BoxConstraints(minWidth: 700, minHeight: 580),
                decoration: const BoxDecoration(color: Color(0x00FFFFFF)),
                child: availability()),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SubmitButton(
              color: AppColors.secondary,
              message: "Done",
              width: 225,
              height: 50,
              onPressed: () async {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      )),
    );
  }

  Widget _createListView() {
    return ListView.builder(
        itemCount: _availability.length,
        itemBuilder: (context, index) {
          return Card(
            color: AppColors.secondary,
            child: ListTile(
              contentPadding: const EdgeInsets.all(10),
              title: Text(_availability[index]),
              trailing: IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.black,
                ),
                onPressed: () async {
                  deleteAvailability(index);
                  SnackBar snackBar = SnackBar(
                    content:
                        Text("Availability Removed :  ${_availability[index]}"),
                    backgroundColor: Theme.of(context).cardColor,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  setState(() {
                    _availability.removeAt(index);
                  });
                },
              ),
            ),
          );
        });
  }
}
